{
  description = "Custom builds of Iosevka";

  inputs = {
    nixpkgs.url     = "nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    {
      overlay = self: super:
        let
          pkgs = nixpkgs.legacyPackages.${super.system};
        in {
          inherit (pkgs) iosevka;
          iosevkaFixed = pkgs.iosevka.override { set = "fixed"; };
          ioslabka = pkgs.iosevka.override {
            set = "fixed";
            privateBuildPlan = {
              family = "Ioslabka";
              design = [
                "v-a-doublestorey"               # cv01
                "v-f-serified"                   # cv84
                "v-i-serified"                   # cv03
                "v-k-cursive"                    # cv70
                "v-l-serified"                   # cv07
                "v-r-serified"                   # cv86
                "v-t-flat-hook"                  # VXDC
                "v-u-with-bar"                   # cv89
                "v-y-cursive"                    # cv49
                "v-capital-g-toothless"          # cv92
                "v-capital-j-serifed-both-sides" # VXDA
                "v-capital-m-flat-bottom"        # VXCJ
                "v-zero-dotted"                  # cv14
                "v-one-base"                     # cv51
                "v-three-flattop"                # cv46
                "v-six-open-contour"             # VXAF
                "v-nine-open-contour"            # cv97
                "v-paren-larger-contour"         # VXAO
                "v-dollar-open"                  # cv38
                "sp-fixed"
                "slab"
              ];
            };
          };
        };
    } // flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ self.overlay ];
        };
      in {
        packages = {
          inherit (pkgs) iosevka iosevkaFixed ioslabka;
        };
        defaultPackage = pkgs.ioslabka;
      });
}
