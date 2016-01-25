<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>图标选择</title>
<meta name="decorator" content="blank" />
<style>
.the-icons {
  margin: 0px;
  padding: 0px;
  list-style: none;
}

.the-icons li {
  float: left;
  padding: 5px;
  width: 25%;
  line-height: 25px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  cursor: pointer;
}

.the-icons i {
  margin: 1px 5px;
  font-size: 16px;
}

.the-icons li:hover {
  background-color: #efefef;
}

.the-icons li.active {
  background-color: #0088CC;
  color: #ffffff;
}
</style>
<script>
    $(function() {
    	$("#icons li").click(function(){
    		$("#icons li").removeClass("active");
    		$(this).addClass("active");
    		$("#icon").val($(this).text());
    	});
    	$("#icons li").each(function(){
    		if ($(this).text()=="${value}"){
    			$(this).click();
    		}
    	});
    	$("#icons li").dblclick(function(){
    		top.$("div[role=dialog]").find("button[i-id=ok]").trigger("click");
    	});
    });
</script>
</head>
<body>
    <input type="hidden" id="icon" value="${value}" />
    <div id="icons">
        <ul class="the-icons">
            <li><i class="glyphicon glyphicon-asterisk"></i>asterisk</li>
            <li><i class="glyphicon glyphicon-plus"></i>plus</li>
            <li><i class="glyphicon glyphicon-euro"></i>euro</li>
            <li><i class="glyphicon glyphicon-eur"></i>eur</li>
            <li><i class="glyphicon glyphicon-minus"></i>minus</li>
            <li><i class="glyphicon glyphicon-cloud"></i>cloud</li>
            <li><i class="glyphicon glyphicon-envelope"></i>envelope</li>
            <li><i class="glyphicon glyphicon-pencil"></i>pencil</li>
            <li><i class="glyphicon glyphicon-glass"></i>glass</li>
            <li><i class="glyphicon glyphicon-music"></i>music</li>
            <li><i class="glyphicon glyphicon-search"></i>search</li>
            <li><i class="glyphicon glyphicon-heart"></i>heart</li>
            <li><i class="glyphicon glyphicon-star"></i>star</li>
            <li><i class="glyphicon glyphicon-star-empty"></i>star-empty</li>
            <li><i class="glyphicon glyphicon-user"></i>user</li>
            <li><i class="glyphicon glyphicon-film"></i>film</li>
            <li><i class="glyphicon glyphicon-th-large"></i>th-large</li>
            <li><i class="glyphicon glyphicon-th"></i>th</li>
            <li><i class="glyphicon glyphicon-th-list"></i>th-list</li>
            <li><i class="glyphicon glyphicon-ok"></i>ok</li>
            <li><i class="glyphicon glyphicon-remove"></i>remove</li>
            <li><i class="glyphicon glyphicon-zoom-in"></i>zoom-in</li>
            <li><i class="glyphicon glyphicon-zoom-out"></i>zoom-out</li>
            <li><i class="glyphicon glyphicon-off"></i>off</li>
            <li><i class="glyphicon glyphicon-signal"></i>signal</li>
            <li><i class="glyphicon glyphicon-cog"></i>cog</li>
            <li><i class="glyphicon glyphicon-trash"></i>trash</li>
            <li><i class="glyphicon glyphicon-home"></i>home</li>
            <li><i class="glyphicon glyphicon-file"></i>file</li>
            <li><i class="glyphicon glyphicon-time"></i>time</li>
            <li><i class="glyphicon glyphicon-road"></i>road</li>
            <li><i class="glyphicon glyphicon-download-alt"></i>download-alt</li>
            <li><i class="glyphicon glyphicon-download"></i>download</li>
            <li><i class="glyphicon glyphicon-upload"></i>upload</li>
            <li><i class="glyphicon glyphicon-inbox"></i>inbox</li>
            <li><i class="glyphicon glyphicon-play-circle"></i>play-circle</li>
            <li><i class="glyphicon glyphicon-repeat"></i>repeat</li>
            <li><i class="glyphicon glyphicon-refresh"></i>refresh</li>
            <li><i class="glyphicon glyphicon-list-alt"></i>list-alt</li>
            <li><i class="glyphicon glyphicon-lock"></i>lock</li>
            <li><i class="glyphicon glyphicon-flag"></i>flag</li>
            <li><i class="glyphicon glyphicon-headphones"></i>headphones</li>
            <li><i class="glyphicon glyphicon-volume-off"></i>volume-off</li>
            <li><i class="glyphicon glyphicon-volume-down"></i>volume-down</li>
            <li><i class="glyphicon glyphicon-volume-up"></i>volume-up</li>
            <li><i class="glyphicon glyphicon-qrcode"></i>qrcode</li>
            <li><i class="glyphicon glyphicon-barcode"></i>barcode</li>
            <li><i class="glyphicon glyphicon-tag"></i>tag</li>
            <li><i class="glyphicon glyphicon-tags"></i>tags</li>
            <li><i class="glyphicon glyphicon-book"></i>book</li>
            <li><i class="glyphicon glyphicon-bookmark"></i>bookmark</li>
            <li><i class="glyphicon glyphicon-print"></i>print</li>
            <li><i class="glyphicon glyphicon-camera"></i>camera</li>
            <li><i class="glyphicon glyphicon-font"></i>font</li>
            <li><i class="glyphicon glyphicon-bold"></i>bold</li>
            <li><i class="glyphicon glyphicon-italic"></i>italic</li>
            <li><i class="glyphicon glyphicon-text-height"></i>text-height</li>
            <li><i class="glyphicon glyphicon-text-width"></i>text-width</li>
            <li><i class="glyphicon glyphicon-align-left"></i>align-left</li>
            <li><i class="glyphicon glyphicon-align-center"></i>align-center</li>
            <li><i class="glyphicon glyphicon-align-right"></i>align-right</li>
            <li><i class="glyphicon glyphicon-align-justify"></i>align-justify</li>
            <li><i class="glyphicon glyphicon-list"></i>list</li>
            <li><i class="glyphicon glyphicon-indent-left"></i>indent-left</li>
            <li><i class="glyphicon glyphicon-indent-right"></i>indent-right</li>
            <li><i class="glyphicon glyphicon-facetime-video"></i>facetime-video</li>
            <li><i class="glyphicon glyphicon-picture"></i>picture</li>
            <li><i class="glyphicon glyphicon-map-marker"></i>map-marker</li>
            <li><i class="glyphicon glyphicon-adjust"></i>adjust</li>
            <li><i class="glyphicon glyphicon-tint"></i>tint</li>
            <li><i class="glyphicon glyphicon-edit"></i>edit</li>
            <li><i class="glyphicon glyphicon-share"></i>share</li>
            <li><i class="glyphicon glyphicon-check"></i>check</li>
            <li><i class="glyphicon glyphicon-move"></i>move</li>
            <li><i class="glyphicon glyphicon-step-backward"></i>step-backward</li>
            <li><i class="glyphicon glyphicon-fast-backward"></i>fast-backward</li>
            <li><i class="glyphicon glyphicon-backward"></i>backward</li>
            <li><i class="glyphicon glyphicon-play"></i>play</li>
            <li><i class="glyphicon glyphicon-pause"></i>pause</li>
            <li><i class="glyphicon glyphicon-stop"></i>stop</li>
            <li><i class="glyphicon glyphicon-forward"></i>forward</li>
            <li><i class="glyphicon glyphicon-fast-forward"></i>fast-forward</li>
            <li><i class="glyphicon glyphicon-step-forward"></i>step-forward</li>
            <li><i class="glyphicon glyphicon-eject"></i>eject</li>
            <li><i class="glyphicon glyphicon-chevron-left"></i>chevron-left</li>
            <li><i class="glyphicon glyphicon-chevron-right"></i>chevron-right</li>
            <li><i class="glyphicon glyphicon-plus-sign"></i>plus-sign</li>
            <li><i class="glyphicon glyphicon-minus-sign"></i>minus-sign</li>
            <li><i class="glyphicon glyphicon-remove-sign"></i>remove-sign</li>
            <li><i class="glyphicon glyphicon-ok-sign"></i>ok-sign</li>
            <li><i class="glyphicon glyphicon-question-sign"></i>question-sign</li>
            <li><i class="glyphicon glyphicon-info-sign"></i>info-sign</li>
            <li><i class="glyphicon glyphicon-screenshot"></i>screenshot</li>
            <li><i class="glyphicon glyphicon-remove-circle"></i>remove-circle</li>
            <li><i class="glyphicon glyphicon-ok-circle"></i>ok-circle</li>
            <li><i class="glyphicon glyphicon-ban-circle"></i>ban-circle</li>
            <li><i class="glyphicon glyphicon-arrow-left"></i>arrow-left</li>
            <li><i class="glyphicon glyphicon-arrow-right"></i>arrow-right</li>
            <li><i class="glyphicon glyphicon-arrow-up"></i>arrow-up</li>
            <li><i class="glyphicon glyphicon-arrow-down"></i>arrow-down</li>
            <li><i class="glyphicon glyphicon-share-alt"></i>share-alt</li>
            <li><i class="glyphicon glyphicon-resize-full"></i>resize-full</li>
            <li><i class="glyphicon glyphicon-resize-small"></i>resize-small</li>
            <li><i class="glyphicon glyphicon-exclamation-sign"></i>exclamation-sign</li>
            <li><i class="glyphicon glyphicon-gift"></i>gift</li>
            <li><i class="glyphicon glyphicon-leaf"></i>leaf</li>
            <li><i class="glyphicon glyphicon-fire"></i>fire</li>
            <li><i class="glyphicon glyphicon-eye-open"></i>eye-open</li>
            <li><i class="glyphicon glyphicon-eye-close"></i>eye-close</li>
            <li><i class="glyphicon glyphicon-warning-sign"></i>warning-sign</li>
            <li><i class="glyphicon glyphicon-plane"></i>plane</li>
            <li><i class="glyphicon glyphicon-calendar"></i>calendar</li>
            <li><i class="glyphicon glyphicon-random"></i>random</li>
            <li><i class="glyphicon glyphicon-comment"></i>comment</li>
            <li><i class="glyphicon glyphicon-magnet"></i>magnet</li>
            <li><i class="glyphicon glyphicon-chevron-up"></i>chevron-up</li>
            <li><i class="glyphicon glyphicon-chevron-down"></i>chevron-down</li>
            <li><i class="glyphicon glyphicon-retweet"></i>retweet</li>
            <li><i class="glyphicon glyphicon-shopping-cart"></i>shopping-cart</li>
            <li><i class="glyphicon glyphicon-folder-close"></i>folder-close</li>
            <li><i class="glyphicon glyphicon-folder-open"></i>folder-open</li>
            <li><i class="glyphicon glyphicon-resize-vertical"></i>resize-vertical</li>
            <li><i class="glyphicon glyphicon-resize-horizontal"></i>resize-horizontal</li>
            <li><i class="glyphicon glyphicon-hdd"></i>hdd</li>
            <li><i class="glyphicon glyphicon-bullhorn"></i>bullhorn</li>
            <li><i class="glyphicon glyphicon-bell"></i>bell</li>
            <li><i class="glyphicon glyphicon-certificate"></i>certificate</li>
            <li><i class="glyphicon glyphicon-thumbs-up"></i>thumbs-up</li>
            <li><i class="glyphicon glyphicon-thumbs-down"></i>thumbs-down</li>
            <li><i class="glyphicon glyphicon-hand-right"></i>hand-right</li>
            <li><i class="glyphicon glyphicon-hand-left"></i>hand-left</li>
            <li><i class="glyphicon glyphicon-hand-up"></i>hand-up</li>
            <li><i class="glyphicon glyphicon-hand-down"></i>hand-down</li>
            <li><i class="glyphicon glyphicon-circle-arrow-right"></i>circle-arrow-right</li>
            <li><i class="glyphicon glyphicon-circle-arrow-left"></i>circle-arrow-left</li>
            <li><i class="glyphicon glyphicon-circle-arrow-up"></i>circle-arrow-up</li>
            <li><i class="glyphicon glyphicon-circle-arrow-down"></i>circle-arrow-down</li>
            <li><i class="glyphicon glyphicon-globe"></i>globe</li>
            <li><i class="glyphicon glyphicon-wrench"></i>wrench</li>
            <li><i class="glyphicon glyphicon-tasks"></i>tasks</li>
            <li><i class="glyphicon glyphicon-filter"></i>filter</li>
            <li><i class="glyphicon glyphicon-briefcase"></i>briefcase</li>
            <li><i class="glyphicon glyphicon-fullscreen"></i>fullscreen</li>
            <li><i class="glyphicon glyphicon-dashboard"></i>dashboard</li>
            <li><i class="glyphicon glyphicon-paperclip"></i>paperclip</li>
            <li><i class="glyphicon glyphicon-heart-empty"></i>heart-empty</li>
            <li><i class="glyphicon glyphicon-link"></i>link</li>
            <li><i class="glyphicon glyphicon-phone"></i>phone</li>
            <li><i class="glyphicon glyphicon-pushpin"></i>pushpin</li>
            <li><i class="glyphicon glyphicon-usd"></i>usd</li>
            <li><i class="glyphicon glyphicon-gbp"></i>gbp</li>
            <li><i class="glyphicon glyphicon-sort"></i>sort</li>
            <li><i class="glyphicon glyphicon-sort-by-alphabet"></i>sort-by-alphabet</li>
            <li><i class="glyphicon glyphicon-sort-by-alphabet-alt"></i>sort-by-alphabet-alt</li>
            <li><i class="glyphicon glyphicon-sort-by-order"></i>sort-by-order</li>
            <li><i class="glyphicon glyphicon-sort-by-order-alt"></i>sort-by-order-alt</li>
            <li><i class="glyphicon glyphicon-sort-by-attributes"></i>sort-by-attributes</li>
            <li><i class="glyphicon glyphicon-sort-by-attributes-alt"></i>sort-by-attributes-alt</li>
            <li><i class="glyphicon glyphicon-unchecked"></i>unchecked</li>
            <li><i class="glyphicon glyphicon-expand"></i>expand</li>
            <li><i class="glyphicon glyphicon-collapse-down"></i>collapse-down</li>
            <li><i class="glyphicon glyphicon-collapse-up"></i>collapse-up</li>
            <li><i class="glyphicon glyphicon-log-in"></i>log-in</li>
            <li><i class="glyphicon glyphicon-flash"></i>flash</li>
            <li><i class="glyphicon glyphicon-log-out"></i>log-out</li>
            <li><i class="glyphicon glyphicon-new-window"></i>new-window</li>
            <li><i class="glyphicon glyphicon-record"></i>record</li>
            <li><i class="glyphicon glyphicon-save"></i>save</li>
            <li><i class="glyphicon glyphicon-open"></i>open</li>
            <li><i class="glyphicon glyphicon-saved"></i>saved</li>
            <li><i class="glyphicon glyphicon-import"></i>import</li>
            <li><i class="glyphicon glyphicon-export"></i>export</li>
            <li><i class="glyphicon glyphicon-send"></i>send</li>
            <li><i class="glyphicon glyphicon-floppy-disk"></i>floppy-disk</li>
            <li><i class="glyphicon glyphicon-floppy-saved"></i>floppy-saved</li>
            <li><i class="glyphicon glyphicon-floppy-remove"></i>floppy-remove</li>
            <li><i class="glyphicon glyphicon-floppy-save"></i>floppy-save</li>
            <li><i class="glyphicon glyphicon-floppy-open"></i>floppy-open</li>
            <li><i class="glyphicon glyphicon-credit-card"></i>credit-card</li>
            <li><i class="glyphicon glyphicon-transfer"></i>transfer</li>
            <li><i class="glyphicon glyphicon-cutlery"></i>cutlery</li>
            <li><i class="glyphicon glyphicon-header"></i>header</li>
            <li><i class="glyphicon glyphicon-compressed"></i>compressed</li>
            <li><i class="glyphicon glyphicon-earphone"></i>earphone</li>
            <li><i class="glyphicon glyphicon-phone-alt"></i>phone-alt</li>
            <li><i class="glyphicon glyphicon-tower"></i>tower</li>
            <li><i class="glyphicon glyphicon-stats"></i>stats</li>
            <li><i class="glyphicon glyphicon-sd-video"></i>sd-video</li>
            <li><i class="glyphicon glyphicon-hd-video"></i>hd-video</li>
            <li><i class="glyphicon glyphicon-subtitles"></i>subtitles</li>
            <li><i class="glyphicon glyphicon-sound-stereo"></i>sound-stereo</li>
            <li><i class="glyphicon glyphicon-sound-dolby"></i>sound-dolby</li>
            <li><i class="glyphicon glyphicon-sound-5-1"></i>sound-5-1</li>
            <li><i class="glyphicon glyphicon-sound-6-1"></i>sound-6-1</li>
            <li><i class="glyphicon glyphicon-sound-7-1"></i>sound-7-1</li>
            <li><i class="glyphicon glyphicon-copyright-mark"></i>copyright-mark</li>
            <li><i class="glyphicon glyphicon-registration-mark"></i>registration-mark</li>
            <li><i class="glyphicon glyphicon-cloud-download"></i>cloud-download</li>
            <li><i class="glyphicon glyphicon-cloud-upload"></i>cloud-upload</li>
            <li><i class="glyphicon glyphicon-tree-conifer"></i>tree-conifer</li>
            <li><i class="glyphicon glyphicon-tree-deciduous"></i>tree-deciduous</li>
            <li><i class="glyphicon glyphicon-cd"></i>cd</li>
            <li><i class="glyphicon glyphicon-save-file"></i>save-file</li>
            <li><i class="glyphicon glyphicon-open-file"></i>open-file</li>
            <li><i class="glyphicon glyphicon-level-up"></i>level-up</li>
            <li><i class="glyphicon glyphicon-copy"></i>copy</li>
            <li><i class="glyphicon glyphicon-paste"></i>paste</li>
            <li><i class="glyphicon glyphicon-alert"></i>alert</li>
            <li><i class="glyphicon glyphicon-equalizer"></i>equalizer</li>
            <li><i class="glyphicon glyphicon-king"></i>king</li>
            <li><i class="glyphicon glyphicon-queen"></i>queen</li>
            <li><i class="glyphicon glyphicon-pawn"></i>pawn</li>
            <li><i class="glyphicon glyphicon-bishop"></i>bishop</li>
            <li><i class="glyphicon glyphicon-knight"></i>knight</li>
            <li><i class="glyphicon glyphicon-baby-formula"></i>baby-formula</li>
            <li><i class="glyphicon glyphicon-tent"></i>tent</li>
            <li><i class="glyphicon glyphicon-blackboard"></i>blackboard</li>
            <li><i class="glyphicon glyphicon-bed"></i>bed</li>
            <li><i class="glyphicon glyphicon-apple"></i>apple</li>
            <li><i class="glyphicon glyphicon-erase"></i>erase</li>
            <li><i class="glyphicon glyphicon-hourglass"></i>hourglass</li>
            <li><i class="glyphicon glyphicon-lamp"></i>lamp</li>
            <li><i class="glyphicon glyphicon-duplicate"></i>duplicate</li>
            <li><i class="glyphicon glyphicon-piggy-bank"></i>piggy-bank</li>
            <li><i class="glyphicon glyphicon-scissors"></i>scissors</li>
            <li><i class="glyphicon glyphicon-bitcoin"></i>bitcoin</li>
            <li><i class="glyphicon glyphicon-btc"></i>btc</li>
            <li><i class="glyphicon glyphicon-xbt"></i>xbt</li>
            <li><i class="glyphicon glyphicon-yen"></i>yen</li>
            <li><i class="glyphicon glyphicon-jpy"></i>jpy</li>
            <li><i class="glyphicon glyphicon-ruble"></i>ruble</li>
            <li><i class="glyphicon glyphicon-rub"></i>rub</li>
            <li><i class="glyphicon glyphicon-scale"></i>scale</li>
            <li><i class="glyphicon glyphicon-ice-lolly"></i>ice-lolly</li>
            <li><i class="glyphicon glyphicon-ice-lolly-tasted"></i>ice-lolly-tasted</li>
            <li><i class="glyphicon glyphicon-education"></i>education</li>
            <li><i class="glyphicon glyphicon-option-horizontal"></i>option-horizontal</li>
            <li><i class="glyphicon glyphicon-option-vertical"></i>option-vertical</li>
            <li><i class="glyphicon glyphicon-menu-hamburger"></i>menu-hamburger</li>
            <li><i class="glyphicon glyphicon-modal-window"></i>modal-window</li>
            <li><i class="glyphicon glyphicon-oil"></i>oil</li>
            <li><i class="glyphicon glyphicon-grain"></i>grain</li>
            <li><i class="glyphicon glyphicon-sunglasses"></i>sunglasses</li>
            <li><i class="glyphicon glyphicon-text-size"></i>text-size</li>
            <li><i class="glyphicon glyphicon-text-color"></i>text-color</li>
            <li><i class="glyphicon glyphicon-text-background"></i>text-background</li>
            <li><i class="glyphicon glyphicon-object-align-top"></i>object-align-top</li>
            <li><i class="glyphicon glyphicon-object-align-bottom"></i>object-align-bottom</li>
            <li><i class="glyphicon glyphicon-object-align-horizontal"></i>object-align-horizontal</li>
            <li><i class="glyphicon glyphicon-object-align-left"></i>object-align-left</li>
            <li><i class="glyphicon glyphicon-object-align-vertical"></i>object-align-vertical</li>
            <li><i class="glyphicon glyphicon-object-align-right"></i>object-align-right</li>
            <li><i class="glyphicon glyphicon-triangle-right"></i>triangle-right</li>
            <li><i class="glyphicon glyphicon-triangle-left"></i>triangle-left</li>
            <li><i class="glyphicon glyphicon-triangle-bottom"></i>triangle-bottom</li>
            <li><i class="glyphicon glyphicon-triangle-top"></i>triangle-top</li>
            <li><i class="glyphicon glyphicon-console"></i>console</li>
            <li><i class="glyphicon glyphicon-superscript"></i>superscript</li>
            <li><i class="glyphicon glyphicon-subscript"></i>subscript</li>
            <li><i class="glyphicon glyphicon-menu-left"></i>menu-left</li>
            <li><i class="glyphicon glyphicon-menu-right"></i>menu-right</li>
            <li><i class="glyphicon glyphicon-menu-down"></i>menu-down</li>
            <li><i class="glyphicon glyphicon-menu-up"></i>menu-up</li>
        </ul>
    </div>
</body>