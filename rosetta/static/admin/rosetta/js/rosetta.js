const rosetta_settings = JSON.parse(document.getElementById('rosetta-settings-js').textContent);

$(document).ready(function() {

    $('.location a').show().toggle(function() {
        $('.hide', $(this).parent()).show();
    }, function() {
        $('.hide', $(this).parent()).hide();
    });

  if (rosetta_settings.ENABLE_TRANSLATION_SUGGESTIONS) {
    if (rosetta_settings.server_auth_key) {
    $('a.suggest').click(function(e){
        e.preventDefault();
        var a = $(this);
        var str = a.html();
        var orig = $('.original .message', a.parents('tr')).html();
        var trans=$('textarea',a.parent().parent());
        var sourceLang = rosetta_settings.MESSAGES_SOURCE_LANGUAGE_CODE;
        var destLang = rosetta_settings.rosetta_i18n_lang_code_normalized;
        var provider = $('.translation-provider', a.parent()).val() || 'default';

        orig = unescape(orig).replace(/<br\s?\/?>/g,'\n').replace(/<code>/,'').replace(/<\/code>/g,'').replace(/&gt;/g,'>').replace(/&lt;/g,'<');
        a.attr('class','suggesting').html('...');

        if (provider === 'libretranslate' && rosetta_settings.LIBRETRANSLATE_URL) {
            // Direct LibreTranslate API call
            var apiUrl = rosetta_settings.LIBRETRANSLATE_URL;
            if (!apiUrl.endsWith('/translate')) {
                apiUrl = apiUrl.replace(/\/$/, '') + '/translate';
            }
            
            $.ajax({
                url: apiUrl,
                method: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({
                    q: orig,
                    source: sourceLang.split('-')[0],
                    target: destLang.split('-')[0]
                }),
                success: function(data) {
                    if (data.translatedText) {
                        trans.val(unescape(data.translatedText).replace(/&#39;/g,'\'').replace(/&quot;/g,'"').replace(/%\s+(\([^\)]+\))\s*s/g,' %$1s '));
                        a.removeClass('suggesting').addClass('suggest').html(str);
                        a.hide();
                    } else {
                        a.removeClass('suggesting').addClass('suggest').text('Error: No translation returned');
                    }
                },
                error: function(xhr, status, error) {
                    var errorMsg = 'LibreTranslate error';
                    try {
                        var response = JSON.parse(xhr.responseText);
                        if (response.error) {
                            errorMsg = 'LibreTranslate: ' + response.error;
                        }
                    } catch (e) {
                        if (xhr.status === 0) {
                            errorMsg = 'LibreTranslate: Connection failed (check CORS)';
                        } else {
                            errorMsg = 'LibreTranslate: HTTP ' + xhr.status;
                        }
                    }
                    a.removeClass('suggesting').addClass('suggest').text(errorMsg);
                }
            });
        } else {
            // Default server-side translation
            $.getJSON(rosetta_settings.translate_text_url, {
                    from: sourceLang,
                    to: destLang,
                    text: orig,
                    provider: provider === 'libretranslate' ? 'libretranslate' : undefined
                },
                function(data) {
                    if (data.success){
                        trans.val(unescape(data.translation).replace(/&#39;/g,'\'').replace(/&quot;/g,'"').replace(/%\s+(\([^\)]+\))\s*s/g,' %$1s '));
                        a.removeClass('suggesting').addClass('suggest').html(str);
                        a.hide();
                    } else {
                        a.removeClass('suggesting').addClass('suggest').text(data.error);
                    }
                }
            );
        }
    });
  } else if (rosetta_settings.YANDEX_TRANSLATE_KEY) {
    $('a.suggest').click(function(e){
        e.preventDefault();
        var a = $(this);
        var str = a.html();
        var orig = $('.original .message', a.parents('tr')).html();
        var trans=$('textarea',a.parent());
        var apiUrl = "https://translate.yandex.net/api/v1.5/tr.json/translate";
        var destLangRoot = rosetta_settings.rosetta_i18n_lang_code.split('-')[0];
        var lang = rosetta_settings.MESSAGES_SOURCE_LANGUAGE_CODE + '-' + destLangRoot;

        a.attr('class','suggesting').html('...');

        var apiData = {
            error: 'onTranslationError',
            success: 'onTranslationComplete',
            lang: lang,
            key: rosetta_settings.YANDEX_TRANSLATE_KEY,
            format: 'html',
            text: orig
        };

        $.ajax({
            url: apiUrl,
            data: apiData,
            dataType: 'jsonp',
            success: function(response) {
                if (response.code == 200) {
                    trans.val(response.text[0].replace(/<br>/g, '\n').replace(/<\/?code>/g, '').replace(/&lt;/g, '<').replace(/&gt;/g, '>'));
                    a.hide();
                } else {
                    a.text(response);
                }
            },
            error: function(response) {
                a.text(response);
            }
        });
    });
  }
  }

    $('td.plural').each(function(i) {
        var td = $(this), trY = parseInt(td.closest('tr').offset().top);
        $('textarea', $(this).closest('tr')).each(function(j) {
            var textareaY=  parseInt($(this).offset().top) - trY;
            $($('.part',td).get(j)).css('top',textareaY + 'px');
        });
    });

    $('.translation textarea')

    .blur(function() {
        if($(this).val()) {
            $('.alert', $(this).parents('tr')).remove();
            var RX = /%(?:\([^\s\)]*\))?[sdf]|\{[\w\d_]+?\}/g,
                origs=$(this).parents('tr').find('.original span').html().match(RX),
                trads=$(this).val().match(RX),
                error = $('<span class="alert">Unmatched variables</span>');

            if (origs && trads) {
                for (var i = trads.length; i--;){
                    var key = trads[i];
                    if (-1 == $.inArray(key, origs)) {
                        $(this).before(error)
                        return false;
                    }
                }
                return true;
            } else {
                if (!(origs === null && trads === null)) {
                    $(this).before(error);
                    return false;
                }
            }
            return true;
        }
    })

    .keyup(function () {
        var cb = $(this).parents('tr').find('td.c input[type="checkbox"]');
        if(cb.is(':checked')){
            cb[0].checked = false;
            cb.removeAttr( 'checked')
        }

    })

    .eq(0).focus();

    $('#action-toggle').change(function(){
        jQuery('tbody td.c input[type="checkbox"]').each(function(i, e) {
            if($('#action-toggle').is(':checked')) {
                $(e).attr('checked', 'checked');
            } else {
                $(e).removeAttr('checked');
            }
        });
    });

});
