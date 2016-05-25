~~Designet er ekstremt inkonsitent og der alt for mange forskellige elementer
til et site som firefund. Jeg vil ikke bruge tid på at lave sammenligninger,
men vil bare påpege at ingen sammemlignlige sites har så mange forskellige
elementer.~~

~~Hvis vi skal nå i mål i rimelig tid, så skal vi have dræbt nogen "darlings"
Forhåbelig kan vores identificeringsproces gøre det nemmere at få et konkret
overblik. Det vil IKKE sige at vi skal fjerne nogen moduler, men snare at
skal lave vores moduler ud fra nogle færre elementer. Det vil også gøre vores
moduler mere ensartet og øge konsistencen af designet.
Et eksempel [BRUG TEKST SOM EKSEMPEL]: vi har 2 forskellige tekst design ti
 navigation links og [FIND ET GODT EKSEMPEL]. Hvis vi bruge det samme tekst
 design til begge dele spare vi tid og opnår et mere strømlinet design.~~

~~Det er vigtigt i forhold til vedligeholdelse af sitet at vi IKKE har for
mange varianter af ens funktionalitet. Det vil fx sige at vi ikke skal have
8 forskellige overskrifter, men kun 4. Ikke skal have 20 tekst elementer,
men kun 5-6. Og så videre.~~


## Ordforklaring ##
BEM splits components classes into three groups:

**B**lock: The sole root of the component.<br>
**E**lement: A component part of the Block.<br>
**M**odifier: A variant or extension of the Block or Element.
```
NAVN        EKSEMPEL
+ element   En knap.
+ module    En samling af knapper.
+ component En samling af knapper, hvor et klik skifter et andet modul.

+ BLOCK     f-breadcrumbs
+ ELEMENT   f-breadcrumbs__link
+ MODIFIER  f-breadcrumbs__link_active
```
Jeg har markeret alle elementer i rødt [og modulerne i grønt]. Komponenterne
er ikke så vigtige i første omgang, men vi skal få dem opstillet på et
tidspunkt, så vi kan have en arbejdsplan.

Bemærk at der ikke er nogen klasser for "hover" og "blur". Vi bruger i stede
CSS pseudo klasser. Til input elementer bliver attributen "placeholder"
automatisk *stylet*. Dette gælder også nogle andre attributter, så som
"disabled" på en knap. Men ikke på en input.

Eksempel:

*f-button-group*
```html
<div class="f-button-group">
	<button
		class="f-button-group__button"
		disabled>
		Donate
	</button>
</div>
```
*f-text-input*
```html
<div class="f-text-input f-text-input_disable">
	<label class="f-text-input__label">
		Name
		<input
			class="f-text-input__text-field"
			type="text"
			placeholder="Name, organization, newspaper, etc."
			autocomplete="organization"
		/>
	</label>
</div>
```
*For technical reasons we have to put the "disable" state on the BLOCK,
in order to style the label in a "disabled" state.*

## BEVM or BEM? ##

**BEVM**

**B**lock **E**lement **V**ariation **M**odifier

`f-block__element--variation -modifier`

fx: `f-breadcrumbs__link -active` & `f-small-text--red`

TODO: button example

## Classes as BEM tree ##

```
01. Our logo.
	BLOCK f-branding

02. Site navigation links.
	BLOCK f-navigation
		ELEMENT f-navigation__link

03. [REMOVED FROM DESIGN] Site breadcrumbs.
	Represent the vertical steps taken in our site,
	as seen on a sitemap.
	BLOCK f-breadcrumbs
		ELEMENT f-breadcrumbs__link
		MODIFIER f-breadcrumbs__link_active

04. A big heading with a black left justified box. h1
	BLOCK f-heading

05. A container that put 3 buttons per row with equal space between them,
	where the first and last button are justified to the edge.
	BLOCK f-button-group
		ELEMENT f-button-group__button
		MODIFIER f-button-group__button_active

06. Small text snippets, used on our Manifest page (About Codex-01).
	BLOCK f-small-text
	MODIFIER f-small-text_attention
		ELEMENT f-small-text__heading
		ELEMENT f-small-text__text

07. A container that has some visible text but via a click can display
	much more text.
	BLOCK f-accordian
	MODIFIER f-accordian_attention
		ELEMENT f-accordian__heading
		ELEMENT f-accordian__cuff-text
		ELEMENT f-accordian__arrow
		MODIFIER f-accordian__arrow_active

08. A group of left justified buttons.
	BLOCK f-button-row
		ELEMENT f-button-row__button
		ELEMENT f-button-row__button_attention

09. A text input field, with a label, that can be one line
	or multiple lines.
	BLOCK f-text-input
	MODIFIER f-text-input_multiline
	MODIFIER f-text-input_disable
		ELEMENT f-text-input__label
		ELEMENT f-text-input__text-field

10. A list of radio buttons. The "name" attribute MUST share the same value.
	The "checked" attribute can be used to choose which one is pre-selected.
	BLOCK f-radio-group

11. One line of text. Can contain link(s). If you want you can (ab)use
	this block as a multiple line text. Just wrap it in a small grid column.
	Top and bottom margin can be achieved by inserting <br> elements.
	BLOCK f-one-liner
	MODIFIER f-one-liner_center
	MODIFIER f-one-liner_right
	MODIFIER f-one-liner_size_medium
	MODIFIER f-one-liner_size_big

12. A container that put 3 blocks per row with equal space between them,
	where the first and last block are justified to the edge. 
	BLOCK f-thumbnail-group

13. A two-sided card with a front image (also used as
	background for the backside) and card text on the backside. 
	BLOCK f-thumbnail-group__card
		ELEMENT f-thumbnail-group__heading
		ELEMENT f-thumbnail-group__byline
		ELEMENT f-thumbnail-group__text
		ELEMENT f-thumbnail-group__image

14. Standard firefund text. Can contain links. The text element is
	optional.
	BLOCK f-text
		ELEMENT f-text__heading
		ELEMENT f-text__text

15. An image with an optional caption text. By default it has the same width
	as its container block.
	BLOCK f-image
	MODIFIER f-image_right (float)
	MODIFIER f-image_left (float)
		ELEMENT f-image__image
		ELEMENT f-image__caption

16. A bullet list or number list. (About Who-01, Project-01)
	BLOCK f-list

17. Hero. Has a full width background image with text content on top.
	Image inserted as html img tag and via js set as css background-image. The
	image is initial hidden but is reveal in a translateY/opacity movement, when
	the js has run.
	BLOCK f-hero
		ELEMENT f-hero__heading
		ELEMENT f-hero__text

18. A huge centered heading-text element that spans 100% of its container. 
	BLOCK f-huge-heading

19. A numbered block with heading and separator. Below the separator, is
	text and image.
	BLOCK f-numbered-block
		ELEMENT f-numbered-block__number
		ELEMENT f-numbered-block__heading
		~~ELEMENT f-numbered-block__separator~~
		ELEMENT f-numbered-block__text
		ELEMENT f-numbered-block__image

20. One line of text. A kind to 11 but with different font size
	and a border.
	BLOCK f-one-liner-border

21. Hero slider
	BLOCK f-slider
		ELEMENT f-slider__heading
		ELEMENT f-slider__text
		ELEMENT f-slider__button-group
		ELEMENT f-slider__button

22. Project thumbnail (link to project page). Image fades into
	color on mouse hover on desktop. On mobile, the images are in
	color.
	BLOCK f-project-thumbnail
	MODIFIER f-project-thumbnail_reverse
		ELEMENT f-project-thumbnail__heading
		ELEMENT f-project-thumbnail__byline
		ELEMENT f-project-thumbnail__text
		ELEMENT f-project-thumbnail__summary
		ELEMENT f-project-thumbnail__progress
		ELEMENT f-project-thumbnail__image

23. Mini project thumbnail
	BLOCK f-miniproject-thumbnail
		ELEMENT f-miniproject-thumbnail__image
		ELEMENT f-miniproject-thumbnail__image-text
		ELEMENT f-miniproject-thumbnail__heading (1-2 lines but same height, flexbox centered)
		ELEMENT f-miniproject-thumbnail__byline
		ELEMENT f-miniproject-thumbnail__text
		ELEMENT f-miniproject-thumbnail__progress

24. Content container
	BLOCK f-content

25. Funding progress indicator
	BLOCK f-progress
	MODIFIER f-progress_small
	MODIFIER f-progress_horizontal
		ELEMENT f-progress__bar
		ELEMENT f-progress__data
		ELEMENT f-progress__data-element

26. Footer
	BLOCK f-footer

27. Site map
	BLOCK f-sitemap
		ELEMENT f-sitemap__branding
		ELEMENT f-sitemap__links

28. Footer text
	BLOCK f-footer-text

29. News letter signup form
	BLOCK f-signup
	MODIFIER f-signup_error
		ELEMENT f-signup__label
		ELEMENT f-signup__feedback-text
		ELEMENT f-signup__input
		ELEMENT f-signup__button

30. Share icons (Project-01, Postpay)
	BLOCK f-icons
	MODIFIER f-icons_vertical
		ELEMENT f-icons__text
		ELEMENT f-icons__icon
		MODIFIER f-icons__icon_reddit
		MODIFIER f-icons__icon_twitter

31. Modal Window
	BLOCK f-modal
	MODIFIER f-modal_visible
	MODIFIER f-modal_autoclosable

32. Payment formular (Normal Payment-01)
	BLOCK f-payment
		MODIFIER f-payment_direct
		MODIFIER f-payment_pledge
		ELEMENT f-payment__heading
		ELEMENT f-payment__text
		ELEMENT f-payment__button
			MODIFIER f-payment__button_narrow
		ELEMENT f-payment__radio
		ELEMENT f-payment__radio-input
		ELEMENT f-payment__footer
		ELEMENT f-payment__footer-text

33. Amount slider
	BLOCK f-amount-slider
		ELEMENT f-amount-slider__text
		ELEMENT f-amount-slider__slider
		ELEMENT f-amount-slider__amount

34. Post-pay heading with a smaller font text under.
	BLOCK f-postpay-heading
		ELEMENT f-postpay-heading__sub
		ELEMENT f-postpay-heading__highlight

35. 
	BLOCK f-postpay-text
		ELEMENT f-postpay-text__highlight

36. Spacer. Creates a horizontal space between elements.
	BLOCK f-spacer

37. Left-side heading. A heading with the background reaching the left
	side of its container.
	BLOCK f-sub-left-heading

38. Video
	BLOCK f-video
	MODIFIER f-video_playing
	MODIFIER f-video_paused
		ELEMENT f-video__play

39. Cuff text. Bold text with big line-height.
	BLOCK f-cuff

40. Donate button
	BLOCK f-donate-button

41. Horizontal button group
	BLOCK f-horizontal-button-group
			ELEMENT f-horizontal-button-group__button

42. Right-side heading. A heading with the background reaching the right
	side of its container.
	BLOCK f-sub-right-heading

43. Donation amount text (Project-01).
	BLOCK f-donation-amount
		ELEMENT f-donation-amount__data
```
