{ config, lib, pkgs, ... }:

let
  lock-false = {
    Value = false;
    Status = "locked";
  };
  lock-true = {
    Value = true;
    Status = "locked";
  };
in {

  options.firefox.enable = lib.mkEnableOption ''
    Install and configure firefox.
  '';

  config = lib.mkIf config.firefox.enable {
    programs = {
      firefox = {
        enable = true;

        # ---- POLICIES ----
        # Check about:policies#documentation for options.
        policies = {
          DisableTelemetry = true;
          DisableFirefoxStudies = true;
          EnableTrackingProtection = {
            Value = true;
            Locked = true;
            Cryptomining = true;
            Fingerprinting = true;
          };
          DisablePocket = true;
          DisableFirefoxAccounts = true;
          DisableAccounts = true;
          DisableFirefoxScreenshots = true;
          OverrideFirstRunPage = "";
          OverridePostUpdatePage = "";
          DontCheckDefaultBrowser = true;
          DisplayBookmarksToolbar =
            "never"; # alternatives: "always" or "newtab"
          DisplayMenuBar =
            "default-off"; # alternatives: "always", "never" or "default-on"
          SearchBar = "unified"; # alternative: "separate"

          # ---- EXTENSIONS ----
          # Check about:support for extension/add-on ID strings.
          # Valid strings for installation_mode are "allowed", "blocked",
          # "force_installed" and "normal_installed".
          ExtensionSettings = {
            "*".installation_mode =
              "blocked"; # blocks all addons except the ones specified below
            # uBlock Origin:
            "uBlock0@raymondhill.net" = {
              install_url =
                "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
              installation_mode = "force_installed";
            };
            adminSettings = {
              userSettings = rec {
                uiTheme = "dark";
                uiAccentCustom = true;
                uiAccentCustom0 = "#8300ff";
                cloudStorageEnabled = lib.mkForce false; # Security liability?
              };
              selectedFilterLists = [
                "adguard-generic"
                "adguard-annoyance"
                "adguard-social"
                "adguard-spyware-url"
              ];
            };
          };

          # ---- PREFERENCES ----
          # Check about:config for options.
          Preferences = {
            "browser.contentblocking.category" = {
              Value = "strict";
              Status = "locked";
            };
            "extensions.pocket.enabled" = lock-false;
            "extensions.screenshots.disabled" = lock-true;
            "browser.topsites.contile.enabled" = lock-false;
            "browser.formfill.enable" = lock-false;
            "browser.search.suggest.enabled" = lock-false;
            "browser.search.suggest.enabled.private" = lock-false;
            "browser.urlbar.suggest.searches" = lock-false;
            "browser.urlbar.showSearchSuggestionsFirst" = lock-false;
            "browser.newtabpage.activity-stream.feeds.section.topstories" =
              lock-false;
            "browser.newtabpage.activity-stream.feeds.snippets" = lock-false;
            "browser.newtabpage.activity-stream.section.highlights.includePocket" =
              lock-false;
            "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" =
              lock-false;
            "browser.newtabpage.activity-stream.section.highlights.includeDownloads" =
              lock-false;
            "browser.newtabpage.activity-stream.section.highlights.includeVisited" =
              lock-false;
            "browser.newtabpage.activity-stream.showSponsored" = lock-false;
            "browser.newtabpage.activity-stream.system.showSponsored" =
              lock-false;
            "browser.newtabpage.activity-stream.showSponsoredTopSites" =
              lock-false;

            "browser.startup.homepage" = "about:blank";

            "browser.urlbar.quicksuggest.enabled" = lock-false;
            "browser.urlbar.suggest.topsites" = lock-false;

            "browser.urlbar.suggest.history" = lock-false;

            "signon.prefillForms" = lock-false;

            "browser.urlbar.autoFill" = lock-false;

            "keyword.enabled" = lock-true;

            "dom.security.https_only_mode" = lock-false;

            "network.cookie.lifetimePolicy" = 0;

            "dom.webnotifications.serviceworker.enabled" = lock-false;

            "dom.push.enabled" = lock-false;

            "privacy.clearOnShutdown.cookies" = lock-false;

            "toolkit.legacyUserProfileCustomizations.stylesheets" = lock-true;

            "network.http.referer.XOriginPolicy" = 0;

            "identity.fxaccounts.enabled" = lock-false;

            "ui.context_menus.after_mouseup" = lock-true;
          };
        };
      };
    };
  };
}
