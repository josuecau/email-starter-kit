# Email Starter Kit ™

> It's an opinionated toolbox for HTML emails.

## Features

* HTML compilation with Pug
* HTML Tidy
* LiveReload support
* Image compression
* Specific optimizations for emailing:
  - `target="_blank"` added to links
  - `title` attribute added to links (from image `alt`)
  - `display: block;` and `border="0"` added to images
  - `border="0"`, `cellpadding="0"`, `cellpadding="0"` added to tables
  - Duplicated properties removed from `style` attributes

## Installation

    $ npm install
    $ npm run build

To run compilation in background:

    $ npm run watch

### Or with Docker:

    $ docker-compose build
    $ docker-compose run --rm --service-ports npm run build
    $ docker-compose run --rm --service-ports npm run watch
