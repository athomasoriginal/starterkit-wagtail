from __future__ import unicode_literals

from wagtail.wagtailcore.models import Page
from config.settings.base import APP_DIR


class HomePage(Page):

    template = str(APP_DIR.path('templates/wagtail/pages/home_page.html'))

    pass
