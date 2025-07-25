from django.test import TestCase, Client
from django.urls import reverse
from django.contrib.auth import get_user_model

# Get the custom User model
User = get_user_model()

class SignupFlowTestCase(TestCase):

    def setUp(self):
        # Initialize a Django test client
        self.client = Client()
        self.signup_url = reverse('app:signup')  # Ensure that you are using the correct URL namespace
        self.welcome_url = reverse('app:welcome_view')

    def test_user_signup_and_welcome_view(self):
        """
        Test the user signup flow, ensuring the user is created, logged in,
        and redirected to the welcome view with the correct context.
        """
        # Simulate a POST request to the signup view with separate day, month, and year fields
        response = self.client.post(self.signup_url, {
            'username': 'testuser',
            'email': 'testuser@example.com',
            'password1': 'password123',
            'password2': 'password123',
            'first_name': 'Test',
            'last_name': 'User',
            'day': '1',  # Day field for DOB
            'month': '1',  # Month field for DOB
            'year': '1990',  # Year field for DOB
            'nationality': 'US',
            'phone_number': '+123456789'
        })

        # Check if the user is redirected after signup
        self.assertEqual(response.status_code, 302)  # A 302 redirect means the signup was successful
        self.assertRedirects(response, self.welcome_url)

        # Check if the user is created
        user = User.objects.filter(username='testuser').first()
        self.assertIsNotNone(user, "The user should have been created.")

        # Check if the user is logged in (session should persist after redirect)
        response = self.client.get(self.welcome_url)
        self.assertEqual(response.status_code, 200)  # Ensure the welcome view is accessed
        self.assertContains(response, "testuser")  # The user's name should be in the response
        
        # Check if the user count is passed to the template
        self.assertIn('user_count', response.context)
        user_count = User.objects.count()
        self.assertEqual(response.context['user_count'], user_count)
        
        # Optional: Check if the video content is being included (if applicable)
        self.assertContains(response, 'video')  # Check if the video tag or content is present in the template
