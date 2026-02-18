{ pkgs, sqlit, ... }:
let
  sqlitPkg = sqlit.packages.${pkgs.system}.default;

  sqlitPython = if sqlitPkg ? python then
    sqlitPkg.python
  else if sqlitPkg ? passthru && sqlitPkg.passthru ? python then
    sqlitPkg.passthru.python
  else
    pkgs.python3;

  pyPkgs = sqlitPython.pkgs;
  driverPath = pyPkgs.makePythonPath [
    pyPkgs.pymysql
    pyPkgs.psycopg2-binary
    pyPkgs.sshtunnel
  ];

  sqlitWithDrivers = pkgs.symlinkJoin {
    name = "sqlit-with-drivers";
    paths = [ sqlitPkg ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/sqlit \
        --prefix PYTHONPATH : ${driverPath}
    '';
  };
in { home.packages = [ sqlitWithDrivers ]; }
