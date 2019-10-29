/// MVC Web Application Tests
// - this unit is a part of the freeware Synopse Basilique framework,
// licensed under a GPL v3 license
unit AppWebMVCTest;

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

{$I Synopse.inc} // cross-platform and cross-compiler conditional definitions

interface

uses
  {$ifdef MSWINDOWS}
  Windows, // for some obscure inlining under Delphi
  {$endif MSWINDOWS}
  SysUtils,
  Classes,
  Variants,
  SynCommons,
  SynTable,
  SynLog,
  mORMot,
  SynTests,
  mORMotHttpServer,
  KdomObjUser,
  KdomObjCommunity,
  KdomServUserAPI,
  KdomServRegister,
  AppWebMVC;

type
  TTestMVCApplication = class(TSynTestCase)
  protected
    fServer: TSQLRestServer;
    fMVCApp: TAppWebMVC;
    fHttp: TSQLHttpServer;
  published
    procedure StartApp;
    procedure UserRegistration;
    procedure ShutdownApp;
  end;


const
  DEBUGMVCAPP = true;

implementation


{ TTestMVCApplication }

procedure TTestMVCApplication.StartApp;
begin
  fServer := TSQLRestServerFullMemory.CreateWithOwnModel(
    [TSQLUser, TSQLUserAuth], {restauth=}false, 'web');
  fServer.CreateMissingTables;
  check(fServer.ServiceDefine(TServiceRegister, [IRegister]) <> nil);
  fMVCApp := TAppWebMVC.Create;
  fMVCApp.Start(fServer);
  fHttp := TSQLHttpServer.Create('8092',fServer
    {$ifndef ONLYUSEHTTPSOCKET},'+',useHttpApiRegisteringURI{$endif});
  fHttp.RootRedirectToURI('web/default');    // redirect / to web/default
  fServer.RootRedirectGet := 'web/default';  // redirect blog to web/default
end;

procedure TTestMVCApplication.UserRegistration;
begin

end;

procedure TTestMVCApplication.ShutdownApp;
begin
  if DEBUGMVCAPP then begin
    writeln('MVC AppServer is running!');
    writeln('check e.g. http://localhost:8092/web/mvc-info');
    writeln('Press [Enter] to continue');
    readln;
    writeln('Server Shutdown...');
  end;
  fHttp.Free;
  fMVCApp.Free;
  fServer.Free;
end;

initialization
  TTextWriter.RegisterCustomJSONSerializerFromTextSimpleType([
    ]);
  TTextWriter.RegisterCustomJSONSerializerFromTextBinaryType([
    ]);
  TTextWriter.RegisterCustomJSONSerializerFromText([
    ]);
  TJSONSerializer.RegisterObjArrayForJSON([
    ]);
  TInterfaceFactory.RegisterInterfaces([
    ]);
end.
