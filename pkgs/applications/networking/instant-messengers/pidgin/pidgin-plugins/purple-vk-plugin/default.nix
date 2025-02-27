{
  lib,
  stdenv,
  fetchhg,
  pidgin,
  cmake,
  libxml2,
}:

let
  version = "40ddb6d";
in
stdenv.mkDerivation {
  pname = "purple-vk-plugin";
  inherit version;

  src = fetchhg {
    url = "https://bitbucket.org/olegoandreev/purple-vk-plugin";
    rev = version;
    sha256 = "02p57fgx8ml00cbrb4f280ak2802svz80836dzk9f1zwm1bcr2qc";
  };

  nativeBuildInputs = [ cmake ];
  buildInputs = [
    pidgin
    libxml2
  ];

  preConfigure = ''
    sed -i -e 's|DESTINATION.*PURPLE_PLUGIN_DIR}|DESTINATION lib/purple-2|' CMakeLists.txt
  '';

  cmakeFlags = [ "-DCMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT=1" ];

  meta = {
    homepage = "https://bitbucket.org/olegoandreev/purple-vk-plugin";
    description = "Vk (russian social network) plugin for Pidgin / libpurple";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.linux;
  };
}
