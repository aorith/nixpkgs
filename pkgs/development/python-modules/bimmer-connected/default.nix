{ lib
, aiofile
, buildPythonPackage
, pythonOlder
, fetchFromGitHub
, pbr
, httpx
, pycryptodome
, pyjwt
, pytestCheckHook
, respx
, time-machine
}:

buildPythonPackage rec {
  pname = "bimmer-connected";
  version = "0.13.10";
  format = "setuptools";

  disabled = pythonOlder "3.6";

  src = fetchFromGitHub {
    owner = "bimmerconnected";
    repo = "bimmer_connected";
    rev = "refs/tags/${version}";
    hash = "sha256-IylA73N3bZOs5HjQGbT6xqokb73iO3bdg5M2KCTX3p4=";
  };

  nativeBuildInputs = [
    pbr
  ];

  PBR_VERSION = version;

  propagatedBuildInputs = [
    aiofile
    httpx
    pycryptodome
    pyjwt
  ];

  nativeCheckInputs = [
    pytestCheckHook
    respx
    time-machine
  ];

  pythonImportsCheck = [
    "bimmer_connected"
  ];

  meta = with lib; {
    changelog = "https://github.com/bimmerconnected/bimmer_connected/releases/tag/${version}";
    description = "Library to read data from the BMW Connected Drive portal";
    homepage = "https://github.com/bimmerconnected/bimmer_connected";
    license = licenses.asl20;
    maintainers = with maintainers; [ dotlambda ];
  };
}
