# -*- coding: utf-8 -*-
"""{{ cookiecutter.repo_name }} URL Configuration

https://docs.djangoproject.com/en/1.8/topics/http/urls/

"""
from django.conf import settings
from django.conf.urls import include, url
from django.conf.urls.static import static
from django.contrib import admin
from django.contrib.staticfiles.storage import staticfiles_storage
from django.http import HttpResponse
from django.views.defaults import (
    server_error
)
from django.views.generic.base import RedirectView

from wagtail.contrib.wagtailapi import urls as wagtailapi_urls
from wagtail.wagtailcore import urls as wagtail_urls
from wagtail.wagtailadmin import urls as wagtailadmin_urls
from wagtail.wagtaildocs import urls as wagtaildocs_urls
from wagtail.wagtailsearch import urls as wagtailsearch_urls


urlpatterns = [

    # www.example.com/500.html
    url(
        regex=r'^500/$',
        view=server_error),
    # www.example.com/django-admin
    url(
        regex=r'^favicon.ico$',
        view=RedirectView.as_view(
            url=staticfiles_storage.url('favicon.ico'),
            permanent=False),
        name="favicon"
    ),
    url(
        regex=r'^django-admin/',
        view=include(admin.site.urls)),
    # www.example.com/admin
    url(
        regex=r'^admin/',
        view=include(wagtailadmin_urls)),
    # www.example.com/search
    url(
        regex=r'^search/',
        view=include(wagtailsearch_urls)),
    # www.example.com/documents
    url(
        regex=r'^documents/',
        view=include(wagtaildocs_urls)),
    # www.example.com/api/vi/{pages, images, documents}
    url(
        regex=r'^api/',
        view=include(wagtailapi_urls)),
    # www.example.com
    url(
        regex=r'',
        view=include(wagtail_urls)),
    # www.example.com/robots.txt
    url(
        regex=r'^robots.txt$',
        view=lambda r: HttpResponse("User-agent: *\nDisallow: /",
                                    content_type="text/plain")),
] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)

# url pattern for django debug toolbar
if settings.DEBUG:
    import debug_toolbar
    urlpatterns += [
        url(r'^__debug__/', include(debug_toolbar.urls)),
    ]
