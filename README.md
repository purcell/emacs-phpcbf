# phpcbf.el [![melpa badge][melpa-badge]][melpa-link] [![melpa stable badge][melpa-stable-badge]][melpa-stable-link]

## Introduction
Format PHP code in Emacs using [PHP_CodeSniffer](https://github.com/squizlabs/PHP_CodeSniffer)'s phpcbf.

## Installation
You can install `phpcbf.el` from [MELPA](http://melpa.org) with package.el
(`M-x package-install phpcbf`).

And you can also install it with [el-get](https://github.com/dimitri/el-get).

## Commands
`phpcbf.el` provides following commands.

#### `phpcbf`
If called interactively, the current buffer is formatted according to `phpcbf:standard`.
Default standard is "PEAR".

#### `phpcbf:before-save`
Add this to init file to run phpcbf on the current buffer when saving:
```elisp
(add-hook 'before-save-hook 'phpcbf:before-save)
```
Note that this will cause php-mode to get loaded the first time
you save any file, kind of defeating the point of autoloading.

## Sample Configuration
```elisp
(require 'phpcbf)

(custom-set-variables
 '(phpcbf:executable "/usr/local/bin/phpcbf")
 '(phpcbf:standard "PSR2")
 '(phpcbf:encoding "utf-8"))

;; Format code before saving.
(add-hook 'before-save-hook 'phpcbf:before-save)
```

## Customize
### `phpcbf:executable`
Location of `phpcbf` command.

### `phpcbf:standard`
The name or path of the coding standard to use (default is PEAR).
Available standards: Generic, MySource, PEAR, PHPCS, PSR1, PSR2, Squiz, Zend.

And more your custom standards. [See here](https://github.com/squizlabs/PHP_CodeSniffer/wiki/Coding-Standard-Tutorial)

### `phpcbf:encoding`
The encoding of the files being fixed (default is iso-8859-1).
iso-8859-1 is PHP_CodeSniffer's default.

## See Also
### [PHP_CodeSniffer](https://github.com/squizlabs/PHP_CodeSniffer)

PHP_CodeSniffer tokenizes PHP, JavaScript and CSS files and detects violations of a defined set of coding standards.

[melpa-link]: http://melpa.org/#/phpcbf
[melpa-stable-link]: http://stable.melpa.org/#/phpcbf
[melpa-badge]: http://melpa.org/packages/phpcbf-badge.svg
[melpa-stable-badge]: http://stable.melpa.org/packages/phpcbf-badge.svg
