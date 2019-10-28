/// continuous integration tests for https://github.com/synopse/basilique
program TestBasilique;

{
    This file is part of Synopse Basilique framework.

    Synopse Basilique framework. Copyright (C) 2019 Arnaud Bouchez
      Synopse Informatique - https://synopse.info

  *** BEGIN LICENSE BLOCK *****
  Version: GPL 3

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <https://www.gnu.org/licenses/>.

  The Original Code is Synopse Basilique framework.

  The Initial Developer of the Original Code is Arnaud Bouchez.

  Portions created by the Initial Developer are Copyright (C) 2019
  the Initial Developer. All Rights Reserved.

  Contributor(s):

  ***** END LICENSE BLOCK *****


  Version 0.1
  - first public release of the Basilique Framework

}

{$APPTYPE CONSOLE}

{$I Synopse.inc} // define conditionals

uses
  {$I SynDprUses.inc} // includes FastMM4 (Delphi) or cthreads (FPC-Linux)
  SynLog,
  SynTests,
  SynCommons,
  SynCrypto,
  mORMot,
  SynCrtSock,
  SynBidirSock,
  KdomObjUser in '..\kdom\obj\KdomObjUser.pas',
  KdomObjUserTests in '..\kdom\obj\KdomObjUserTests.pas',
  KdomObjCommunity in '..\kdom\obj\KdomObjCommunity.pas',
  KdomObjText in '..\kdom\obj\KdomObjText.pas',
  KdomObjThread in '..\kdom\obj\KdomObjThread.pas',
  KdomServUserAPI in '..\kdom\serv\KdomServUserAPI.pas',
  KdomServRegister in '..\kdom\serv\KdomServRegister.pas';

type
  TTestBasilique = class(TSynTestsLogged)
  published
    procedure Kingdom;
  end;


{ TTestBasilique }

procedure TTestBasilique.Kingdom;
begin
  AddCase([TTestUserKingdom]);
end;



begin
  TSynLogTestLog := SQLite3Log; // share the same log file with the whole mORMot
  TSynLogTestLog.Family.HighResolutionTimeStamp := true;
  TTestBasilique.RunAsConsole('Basilique Automated Tests',LOG_VERBOSE);
end.

