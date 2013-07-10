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
    
    EpomAds.prototype.createBanner = function(key, cb) {
        this._callback = cb;
        cordova.exec(null, null, "Epom", "createBanner", [key]);
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