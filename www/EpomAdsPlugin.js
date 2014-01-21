if (typeof cordova !== "undefined") {

    /**
     * Constructor
     */
    function EpomAds() {
        this._callback_willShowAd;

        this._callback_willShowInter;
        this._callback_didLeaveInter;
        this._callback_didFailInter;
    }

    EpomAds.prototype.createInterstitial = function(key, cb, cbleave, cbfail) {
        this._callback_willShowInter = cb;
        this._callback_didLeaveInter = cbleave;
        this._callback_didFailInter = cbfail;

        cordova.exec(null, null, "Epom", "createInterstitial", [key]);
    };
    
    EpomAds.prototype.createBanner = function(key, cb, interval, top) {
        this._callback_willShowAd = cb;

        interval = typeof interval !== 'undefined' ? interval : 0;
        top      = typeof top      !== 'undefined' ? top : 0;

        cordova.exec(null, null, "Epom", "createBanner", [key, interval, top]);
    };
    
    EpomAds.prototype.destroyBanner = function() {
        cordova.exec(null, null, "Epom", "destroyBanner", []);
    };
    
    EpomAds.prototype._willShowAd = function () {
        this._callback_willShowAd();
    };

    EpomAds.prototype._willShowInter = function () {
        this._callback_willShowInter();
    };

    EpomAds.prototype._didLeaveInter = function () {
        this._callback_didLeaveInter();
    };

    EpomAds.prototype._didFailInter = function () {
        this._callback_didFailInter();
    };
    
    cordova.addConstructor(function() {
        if (!window.plugins) {
            window.plugins = {};
        }
        window.plugins.epomAds = new EpomAds();
    });
    
};