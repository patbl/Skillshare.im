let fb_root = null;
let fb_events_bound = false;

$(function() {
  loadFacebookSDK();
  if (!fb_events_bound) { return bindFacebookEvents(); }
});

var bindFacebookEvents = function() {
  $(document)
    .on('page:fetch', saveFacebookRoot)
    .on('page:change', restoreFacebookRoot)
    .on('page:load', () => __guard__(FB, x => x.XFBML.parse()));
  return fb_events_bound = true;
};

var saveFacebookRoot = () => fb_root = $('#fb-root').detach();

var restoreFacebookRoot = function() {
  if ($('#fb-root').length > 0) {
    return $('#fb-root').replaceWith(fb_root);
  } else {
    return $('body').append(fb_root);
  }
};

var loadFacebookSDK = function() {
  window.fbAsyncInit = initializeFacebookSDK;
  return $.getScript("//connect.facebook.net/en_US/all.js#xfbml=1");
};

var initializeFacebookSDK = () =>
  FB.init({
    appId     : '560373057369233',
    channelUrl: '//WWW.YOUR_DOMAIN.COM/channel.html',
    status    : true,
    cookie    : true,
    xfbml     : true
  })
;

function __guard__(value, transform) {
  return (typeof value !== 'undefined' && value !== null) ? transform(value) : undefined;
}