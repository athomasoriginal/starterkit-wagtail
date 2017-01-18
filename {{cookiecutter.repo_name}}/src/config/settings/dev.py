# -*- coding: utf-8 -*-
"""
Django developer settings

- debug mode true
- django-debug-toolbar
- django-extensions

"""

from .base import *  # noqa

# ------------------------------------------------------------------------------
# DEBUG
# ------------------------------------------------------------------------------

DEBUG = env.bool('DJANGO_DEBUG', default=True)

TEMPLATES[0]['OPTIONS']['debug'] = DEBUG

# ------------------------------------------------------------------------------
# DJANGO DEBUG TOOLBAR
# ------------------------------------------------------------------------------
# http://django-debug-toolbar.readthedocs.io/en/1.6/installation.html
DEBUG_TOOLBAR_PATCH_SETTINGS = False

MIDDLEWARE_CLASSES += ('debug_toolbar.middleware.DebugToolbarMiddleware',)
INSTALLED_APPS += ('debug_toolbar', )

INTERNAL_IPS = ('127.0.0.1', '10.0.2.2',)

DEBUG_TOOLBAR_CONFIG = {
    'DISABLE_PANELS': [
        'debug_toolbar.panels.redirects.RedirectsPanel',
    ],
    'SHOW_TEMPLATE_CONTEXT': True,
}

# ------------------------------------------------------------------------------
# DJANGO EXTENSIONS
# ------------------------------------------------------------------------------

# http://django-extensions.readthedocs.org/en/latest/installation_instructions.html
INSTALLED_APPS += ('django_extensions', )

# ------------------------------------------------------------------------------
# TESTING
# ------------------------------------------------------------------------------
