import os
import importlib
from django.core.management.base import BaseCommand
from django.apps import apps
from django.urls import get_resolver, reverse, NoReverseMatch
from django.conf import settings

class Command(BaseCommand):
    help = 'Generate an overview of the project'

    def handle(self, *args, **options):
        self.stdout.write(self.style.SUCCESS("Starting Project Analysis..."))

        # Collect content for the report
        report_content = []
        report_content.append("{% extends 'layouts/base.html' %}")
        report_content.append("{% load static i18n %}")
        report_content.append("{% block title %}Project Analysis Report{% endblock %}")
        report_content.append("{% block content %}")
        report_content.append("<div class='container'>")
        report_content.append("<h1 class='my-4'>Project Analysis Report</h1>")
        report_content.append("<hr>")

        # Bootstrap 5 accordion for categories
        report_content.append("<div class='accordion' id='projectAnalysisAccordion'>")

        # Categorize findings: Django native apps vs custom apps
        report_content.append(self.analyze_structure())

        # Current Features Overview in another dropdown
        report_content.append(self.analyze_features())

        # Close accordion div
        report_content.append("</div>")

        # End of content block
        report_content.append("</div>")
        report_content.append("{% endblock content %}")

        # Write to HTML report file
        self.write_report("\n".join(report_content))

    def analyze_structure(self):
        """
        Analyzes the directory structure of the project and provides an overview.
        """
        project_root = os.getcwd()
        structure_report = []

        # Django native apps and custom apps categorization
        native_apps = []
        custom_apps = []

        # List of native Django apps
        django_native_apps = ['auth', 'admin', 'contenttypes', 'sessions', 'messages', 'staticfiles']

        apps_list = apps.get_app_configs()

        for app in apps_list:
            if app.name in django_native_apps:
                native_apps.append(app.name)
            else:
                custom_apps.append(app.name)

        # Bootstrap accordion for Django native apps
        structure_report.append("""
        <div class="card">
            <div class="card-header" id="headingDjangoNative">
                <h2 class="mb-0">
                    <button class="btn btn-link collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseDjangoNative" aria-expanded="false" aria-controls="collapseDjangoNative">
                        Django Native Apps
                    </button>
                </h2>
            </div>
            <div id="collapseDjangoNative" class="collapse" aria-labelledby="headingDjangoNative" data-bs-parent="#projectAnalysisAccordion">
                <div class="card-body">
                    <ul>
        """)
        for app in native_apps:
            structure_report.append(f"<li>{app}</li>")
        structure_report.append("""
                    </ul>
                </div>
            </div>
        </div>
        """)

        # Bootstrap accordion for custom apps
        structure_report.append("""
        <div class="card">
            <div class="card-header" id="headingCustomApps">
                <h2 class="mb-0">
                    <button class="btn btn-link collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseCustomApps" aria-expanded="false" aria-controls="collapseCustomApps">
                        Custom Apps
                    </button>
                </h2>
            </div>
            <div id="collapseCustomApps" class="collapse" aria-labelledby="headingCustomApps" data-bs-parent="#projectAnalysisAccordion">
                <div class="card-body">
                    <ul>
        """)
        for app in custom_apps:
            structure_report.append(f"<li>{app}</li>")
        structure_report.append("""
                    </ul>
                </div>
            </div>
        </div>
        """)

        return "\n".join(structure_report)

    def analyze_features(self):
        """
        Analyzes the features by looking at views, models, and urls.
        """
        feature_report = []
        feature_report.append("""
        <div class="card">
            <div class="card-header" id="headingFeaturesOverview">
                <h2 class="mb-0">
                    <button class="btn btn-link collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseFeaturesOverview" aria-expanded="false" aria-controls="collapseFeaturesOverview">
                        Features Overview
                    </button>
                </h2>
            </div>
            <div id="collapseFeaturesOverview" class="collapse" aria-labelledby="headingFeaturesOverview" data-bs-parent="#projectAnalysisAccordion">
                <div class="card-body">
        """)

        apps_list = apps.get_app_configs()
        base_domain = "http://localhost:8000/"

        for app in apps_list:
            feature_report.append(f"<h3>Analyzing App: {app.name}</h3>")
            models = app.get_models()

            if models:
                feature_report.append("<h4>Models:</h4><ul>")
                for model in models:
                    feature_report.append(f"<li>{model.__name__}</li>")
                feature_report.append("</ul>")
            else:
                feature_report.append("<p>No models found.</p>")

            # Extracting views and their URLs
            views_module = f"{app.name}.views"
            try:
                views = importlib.import_module(views_module)
                view_names = [attr for attr in dir(views) if callable(getattr(views, attr))]

                if view_names:
                    feature_report.append("<h4>Views and URLs:</h4><ul>")
                    for view in view_names:
                        try:
                            url = reverse(f"{app.name}:{view}")
                            full_url = f"{base_domain}{url}"
                            feature_report.append(f"<li>{view} - <a href='{full_url}'>{full_url}</a></li>")
                        except NoReverseMatch:
                            feature_report.append(f"<li>{view} - No URL found</li>")
                    feature_report.append("</ul>")
                else:
                    feature_report.append("<p>No views found.</p>")
            except ModuleNotFoundError:
                feature_report.append("<p>No views module found.</p>")
            except Exception as e:
                feature_report.append(f"<p>Error loading views: {str(e)}</p>")

            # Analyzing URLs in the urls.py file
            try:
                url_patterns = get_resolver(f"{app.name}.urls").url_patterns
                if url_patterns:
                    feature_report.append("<h4>URLs Found:</h4><ul>")
                    for pattern in url_patterns:
                        try:
                            full_url = f"{base_domain}{pattern.pattern}"
                            feature_report.append(f"<li>{full_url}</li>")
                        except Exception:
                            feature_report.append("<li>Could not reverse URL</li>")
                    feature_report.append("</ul>")
                else:
                    feature_report.append("<p>No URLs found in urls.py</p>")
            except Exception as e:
                feature_report.append(f"<p>Error analyzing URLs: {str(e)}</p>")

        feature_report.append("</div></div></div>")  # Close the card and accordion structure
        return "\n".join(feature_report)

    def write_report(self, content):
        """
        Write the analysis content to an HTML report file.
        """
        report_file = os.path.join(os.getcwd(), "project_report.html")
        with open(report_file, "w") as file:
            file.write(content)

        self.stdout.write(self.style.SUCCESS(f"\nHTML report saved to {report_file}"))
