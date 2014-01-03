if (typeof cordova !== "undefined") {

    /**
     * Constructor
     */
    function EpomAds() {
        this._callback;
    }

    EpomAds.prototype.createInterstitial = function(key) {
        cordova.exec(null, null, "Epom", "createInterstitial", [key]);
    };
    
    EpomAds.prototype.createBanner = function(key, cb, interval, top) {
        this._callback = cb;

        interval = typeof interval !== 'undefined' ? interval : 0;
        top      = typeof top      !== 'undefined' ? top : 0;

        cordova.exec(null, null, "Epom", "createBanner", [key, interval, top]);
    };
    
    EpomAds.prototype.destroyBanner = function() {
        cordova.exec(null, null, "Epom", "destroyBanner", []);
    };
    
    EpomAds.prototype._willShowAd = function () {
        this._callback();
    };
    
    cordova.addConstructor(function() {
        if (!window.plugins) {
            window.plugins = {};
        }
        window.plugins.epomAds = new EpomAds();
    });
    
};