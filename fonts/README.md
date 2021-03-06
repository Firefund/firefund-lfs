Font Guide
==========

Getting fonts ready for web can be a very manual process and font bugs are very
difficult to track down. This is a step by step guide you can use to verify that
your fonts will work on firefund.net.

**Table Of Content**

1. [Download](#Download)
1. [Verify](#Verify)
1. [Optimize](#Optimize)
1. [WOFF](#WOFF)
1. [Implementation](#Implementation)

## Download

First we need a _source_ font so we can build our web fonts.
[Google Fonts](https://fonts.google.com/) is one of the most known places to
download free fonts from, but a lot of others exist.

> This guide will focus on Google Fonts and the TrueType Font format (`.ttf`).
> Another format, called OpenType, is an extension to TrueType and everything in
> this text regarding TrueType is interchangeable with OpenType.
> That is, in this text everywhere it says TrueType,
> you can apply it to OpenType as well.
> https://docs.microsoft.com/typography/opentype/index

After you have found your font, click on the small + circle and then on "Family
Selected".

Here you can get a link to fonts.googleapis.com, which is fine for prototyping and
development but due to how fonts.googleapis.com caching strategy is implemented it
is painfully slow on bad connections like mobile phones. So instead we host fonts
our self, so users don't have to wait 10 seconds to see our pages.

Next you click on the _CUSTOMIZE_ link, where you can choose which font-weights you
want to use. Fonts are pretty big and we do not want too many weights since that can slow down our pages considerably.

Currently (Feb. 2019) we only use the Roboto font and have 3 weights in normal and
italic style.
We use 300 for light, 400 is normal and 700 for bold.
If you choose the same, Google will warn you that it will be slow. Ignore the
message, since Google Fonts is both lying about what you will download and we will
optimize the fonts in a next step.

Click on the download icon (down arrow).

Now open the `.zip` file.

As you can see, Google included the Black and Medium font variants which
**we didn't want**.

You can either unzip all files and delete `Roboto-Black.ttf`,
`Roboto-BlackItalic.ttf`, `Roboto-Medium.ttf`, and `Roboto-MediumItalic.ttf` or
just choose to extract every other file than them.

> It turns out that you get every `.ttf` file from a font with every language
> and all implemented font-features, when you press download. So we will skip a
> larger explanation about language support but just for kicks - scroll
> down to the _Languages_ section on Google Fonts, to see which languages
> Roboto supports.

The fonts hosted on Google Fonts are almost always very old and doesn't contain
all the normal font features found in the same font, had you downloaded it
from elsewhere. If we are to trust the file date of our Roboto fonts, then they
are from January 2013 (6 years old!). But Google Fonts is the easiest site to
search for fonts, that I know.

The next steps will take a lot of time, so we need to be really, **really**, sure
that our source fonts has everything we need.

## Verify

For the purpose of this guide, we will create a new folder in `fonts/`.
Let's call it `myfont`.

Now copy `index.html` and `font.css` from the `Roboto` folder into `myfont`.

```bash
cd fonts
mkdir myfont
cp -v Roboto/index.html myfont
cp -v Roboto/font.css myfont
```

The directory structure in `myfont` should now look like this:

```
myfont/
|- font.css
|- index.html
|- LICENSE.txt
|- Roboto-BoldItalic.ttf
|- Roboto-Bold.ttf
|- Roboto-Italic.ttf
|- Roboto-LightItalic.ttf
|- Roboto-Light.ttf
|- Roboto-Regular.ttf
|- Roboto-ThinItalic.ttf
|- Roboto-Thin.ttf
```

Open `index.html` in your editor and find these two lines at the top of the file:

```html
<!-- <link rel="stylesheet" href="font.css"> -->
<link rel="stylesheet" href="web/font.css">
```

Comment out the `<link>` to `"web/font.css"` and remove the comment around
`<link rel="stylesheet" href="font.css">`.

Like so:

```html
<link rel="stylesheet" href="font.css">
<!-- <link rel="stylesheet" href="web/font.css"> -->
```

To verify our fonts, we need to both visually verify our letters but we also need
to see that the correct font is loaded by browsers. In Chrome you can see
network requests by just opening `index.html` and check the Network pane in
devtools but Firefox will only show you network requests if you see `index.html`
served from a web server.

Since we use `npm` for everything, we are going to install a light weight web
server that run in nodejs.

```bash
npm i -g ecstatic
ecstatic myfont
```

Now open Chrome and Firefox and go to `localhost:8000`.

Open devtools and the Network pane (in Firefox you need to check _Disable cache_).

Open `font.css` in your editor.

`font.css` maps our fonts to a `font-family` in a `@font-face` selector. There
is one `@font-face` selector for each font variation.

```css
@font-face {
  font-family: 'roboto'; /* The name we will use in our CSS */
  src: url(Roboto-Bold.ttf) format('truetype'); /* Location of our font file */
  font-style: normal; /* normal or italic (cursive) */
  font-weight: 700; /* bold = 700, normal = 400, think = 300 */
}
```
_If our font files are called something else, then we have to correct the link
to the font file._

On our test page there is a set of controls at the top.

![Font Demo Controls](docs/font_controls.png)

If you click on Italic and watch your Network pane in devtools, you will see
that `Roboto-RegularItalic.ttf` is 404
([HTTP 404 means that `Roboto-RegularItalic.ttf` is not found](https://httpstatusdogs.com/404-not-found)).

The reason is that our italic font file is called `Roboto-Italic.ttf` but in
`font.css` it is called `Roboto-RegularItalic.ttf`.

```css
@font-face {
  font-family: 'roboto';
  src: url(Roboto-RegularItalic.ttf) format('truetype');
  font-style: italic;
  font-weight: 400;
}
```

You can either change the name in `src` property or rename the file. I prefer
having a similar naming convention for all files, so just as the italic version
of `Roboto-Bold.ttf` is called `Roboto-BoldItalic.ttf`, I prefer to call
`Roboto-Italic.ttf` for `Roboto-RegularItalic.ttf`.

The controls set CSS properties `font-weight` and `font-style` for all HTML.
When you change these properties, you should see that:

1. The correct font file is downloaded (will only be downloaded once)
1. That all text is changed to look how it is suppose to (Light
should be lighter than Normal etc.)

Below the horizontal ruler there is text examples in unicode. Unicode can display
every letter for all languages in the world, but our font might not have a glyph
for it. That is, **the letter will look wrong if our font does not support the letter.**
Whenever a glyph is not supported, the browser will search for it on your system.
We don't have control over which font the browser will find the correct glyph in and
it **will** depend on your device. Android, Windows and macOS have different system
fonts installed, so the result will be different depending on OS and device.
Samsung might pre-install other fonts than Google etc.

Go through all of the control options and check that all characters renders similar.
If they do not, then check that the correct `.ttf` file was loaded.

**If the correct file did load, then the font does not support those characters.**

The Roboto font currently hosted on Google Fonts supports the following character sets:

+ Cyrillic (Supported by Roboto)
+ Cyrillic Extended (Supported by Roboto)
+ Greek (Supported by Roboto) _- contains only Greek math symbols_
+ Greek Extended (Supported by Roboto) _- every Greek letter_
+ Latin (Supported by all Fonts) _- US English ASCII_
+ Latin Extended (Supported by Roboto) _- european letters like æøå_
+ Vietnamese (Supported by Roboto)


## Optimize

Even with only 3 different font weights for 1 font, we still have to download
1.4MB, which is a lot of data, especially because the correct design will not
be displayed until it has loaded.

What we need is a more compact format than TrueType (`.ttf`).
The answer is Web Open Font Format (`.woff`).

We can use an online webfont generator like
[Font Squirrel][Font Squirrel]
to convert our `.ttf` files to `.woff` and `.woff2`.

Go to [Font Squirrel][Font Squirrel] and click on _UPLOAD FONTS_
and choose all of our `.ttf` files. You remembered to
delete the font-weights that we do not need, right?

Check _"Yes, the fonts I'm uploading are legally eligible for web embedding"_.

We have 3 options, the default is _OPTIMAL_ which will remove everything we
need in our font and only work in US English.
**So choose _BASIC_**.

> Under _EXPERT_ there is a lot of interesting font features. But note, that
> just because a font feature exist, it does not mean that your font will
> support that feature. You have to try and have a lot of patience.
> We could set _Subsetting_ which would allow us to exclude Vietnamese
> and Cyrillic from Roboto. Of special interest
> is `Tabular Numerals` which is the numbers specially designed to have equal
> width when next to each other - think a counter where you don't want the numbers
> to jump to the left and right as they change.

Click on _DOWNLOAD YOUR KIT_.
Between uploading fonts and converting them, you can make yourself a cup of coffee.
This **will** take some time.

Unzip the files to `fonts/myfont/web/`.


## WOFF

[Web Open Font Format (`.woff`)](https://en.wikipedia.org/wiki/Web_Open_Font_Format).

`fonts/myfont/web/stylesheet.css` contains very similar CSS as our
`fonts/myfont/fonts.css`.

```css
@font-face {
    font-family: 'robotolight';
    src: url('roboto-light.woff2') format('woff2'),
         url('roboto-light.woff') format('woff');
    font-weight: normal;
    font-style: normal;

}
```
_Font Squirrel can not recognize italic `font-style` or `font-weight`.
Not even the `font-family` name is correct. This highlight a big problem with
fonts - there is very little that can be automated. We have to manually verify
the correctness of our fonts and manually setup our font usage in CSS._

Font Squirrel did get the file path correct and have encoded our TrueType files
to Web Open Font Format (WOFF) files.

With `.woff` and `.woff2` we save several kilo bytes.
`Roboto-Regular.ttf` went from 168KB to 92KB and 65KB, for `.woff` and `.woff2`.
Not all browsers support `.woff2` so we need to serve both.

Copy `myfont/font.css` to `myfont/web/font.css`.

Open both `myfont/web/stylesheet.css` and `myfont/web/font.css` and **copy the new
Font Squirrel generated `src: url()` to `myfont/web/font.css`.**

The result should be:

```css
/* bold */
@font-face {
  font-family: 'roboto';
  src: url(roboto-bold.woff2) format('woff2'),
       url(roboto-bold.woff) format('woff');
  font-style: normal;
  font-weight: 700;
}
/* ...etc. */
```

In `myfont/index.html` you should revert our change, that we did in the beginning
of the [Verify](#Verify) section, so we include our optimized web font instead of
TrueType.

```html
<!-- <link rel="stylesheet" href="font.css"> -->
<link rel="stylesheet" href="web/font.css">
```

Repeat the verification steps that we did for TrueType to check that our
conversion worked as expected.

1. The correct font file is downloaded (will only be downloaded once)
1. That all text is changed to look how it is suppose to (Light should be lighter than Normal etc.)

You will also notice that both Firefox and Chrome supports `.woff2` and will
only download those files and not the `.woff` files.


## Implementation

> [firefund-production][firefund-production] is our
> website. If you can not follow the link, it means **you do not have access**.
> You are welcome to join us and we regularly have intro meetings.
> [Contact us!](https://www.firefund.net/about-contact)

Before you add the new font files to our website, you should delete the files
that we do not need. Delete every file and folder in `myfont/web/` **except
`.woff`, `.woff2` and `font.css`**. Then commit and push everything you just
made to [firefund-lfs][firefund-lfs].

```bash
git add myfont
git commit -m "added new fonts for firefund"
git push -u origin master
```

Now open the folder where you cloned [firefund-production][firefund-production]
at and locate `public/assets/fonts/`.
Copy all `.woff` and `.woff2` files from `myfont/web/` into `public/assets/fonts/`.
Also copy all your TrueType files to `public/assets/fonts/`.

Open `styles/font.css` in your editor.
The `@font-face` declaration looks a little different from what we have seen so far:

```css
/* bold */
@font-face {
  font-family: 'roboto';
  src: local('Roboto Bold'),
       local('Roboto-Bold'),
       url(/assets/fonts/roboto-bold.woff2) format('woff2'),
       url(/assets/fonts/roboto-bold.woff) format('woff'),
       url(/assets/fonts/Roboto-Bold.ttf) format('truetype');
  font-style: normal;
  font-weight: 700;
}
```
_Our production CSS has a `local()` for finding our font on a user's machine
instead of downloading the same font from our server._

> When authors would prefer to use a locally available copy of a given font and
> download it if it's not, local() can be used. The locally-installed
> <font-face-name> argument to local() is a format-specific string that uniquely
> identifies a single font face within a larger family.
> For OpenType and TrueType fonts, this string is used to match only the
> Postscript name or the full font name in the name table of locally available
> fonts. Which type of name is used varies by platform and font, so authors should
> include both of these names to assure proper matching across platforms.
> https://drafts.csswg.org/css-fonts-3/#src-desc

As you probably have noticed from our verification, the browser will only download
a font if it is used. If a page does not use `Roboto Bold Italic`, then that
font file will not be downloaded, even though our CSS defining that font is
downloaded. But it would be even better if a user didn't have to download our
font at all. That is where `local()` shines. Unfortunately, we don't know the
name of `Roboto Bold Italic` on a user machine. As I've said before, fonts
are usually preinstalled by a device vendor, e.i. Samsung could install
`Roboto Bold Italic` with one PostScript name (PSName) and Apple with yet
another. But even though there is some standardization inside Adobe for font
names,
[trying to get it right across platforms](http://rachaelmoore.name/posts/design/css/find-font-name-css-family-stack/)
is just ridiculous.

But we're really only interested in the exact font that we have manually
downloaded and verified, so we can use a tool like
[FontForge](http://fontforge.github.io/en-US/) or ask Google Fonts.
We can only ask Google Fonts for fonts hosted with them but it's fairly easy to
do. In your browser go to
[https://fonts.googleapis.com/css?family=Roboto:700,700italic,400,400italic,300,300italic](https://fonts.googleapis.com/css?family=Roboto:700,700italic,400,400italic,300,300italic).

```css
/* cyrillic-ext */
@font-face {
  font-family: 'Roboto';
  font-style: italic;
  font-weight: 300;
  src: local('Roboto Light Italic'),
       local('Roboto-LightItalic'),
       url(https://fonts.gstatic.com/s/roboto/v18/KFOjCnqEu92Fr1Mu51TjASc3CsTKlA.woff2) format('woff2');
  unicode-range: U+0460-052F, U+1C80-1C88, U+20B4, U+2DE0-2DFF, U+A640-A69F, U+FE2E-FE2F;
}
```

Google Fonts tells us it is called `Roboto Light Italic` or `Roboto-LightItalic`.
If I take the same font and open it in FontForge, I'm told it's called
`Roboto-LightItalic`.

> In FontForge, you can get the font information by opening the font file and
> select [Element](https://fontforge.github.io/elementmenu.html)->
> [Font Info...](https://fontforge.github.io/fontinfo.html)

**Copy in the PSName for each font variation into `styles/font.css`.** While almost
all browsers support WOFF, it doesn't hurt to also add our
original TrueType, in case a browser doesn't understand WOFF. And it gives us a
backup of our original font file in case we need to create a new format in the
future.

Now that we have defined our font, we want to use it!
In `styles/base.css` we have defined that every element should use `roboto`.

```css
* { font-family: "roboto"; }
```

Non of our [BEM blocks](http://getbem.com/naming/) in `styles/blocks/` sets
`font-family`. So if you want to change font for our entire website,
`styles/base.css` is the place to do it. Of course, you can set another
`font-family` in a specific Block. Just remember that it will add complexity to
maintaining our website and might break the overall design experience.

Finally we only need to create a new `bundle.css` that we can use on our website.
Write `make prod` in your terminal in the `firefund-production` folder and
push to our staging server.

#### Congratulations! ####


[firefund-lfs]: https://github.com/Firefund/firefund-lfs
[firefund-production]: https://github.com/Firefund/firefund-production/
[Font Squirrel]: https://www.fontsquirrel.com/tools/webfont-generator
