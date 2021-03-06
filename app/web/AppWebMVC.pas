/// MVC Web Application Controller
// - Views are Mustache HTML templates, and Model our KDD services
// - this unit is a part of the freeware Synopse Basilique framework,
// licensed under a GPL v3 license
unit AppWebMVC;

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
  mORMotMVC,
  KdomObjUser,
  KdomObjCommunity,
  KdomObjText,
  KdomObjThread,
  KdomServUserAPI;

type
  IAppWebMVC = interface(IMVCApplication)
    ['{F1BD0553-F3EF-496E-A2E4-F21A4A7E7959}']
  end;

  TAppWebMVC = class(TMVCApplication, IAppWebMVC)
  public
    procedure Start(aServer: TSQLRestServer); reintroduce;
  published
    procedure Default(var Scope: variant);
  end;


implementation


{ TAppWebMVC }

procedure TAppWebMVC.Start(aServer: TSQLRestServer);
begin
  inherited Start(aServer, TypeInfo(IAppWebMVC));
  fMainRunner := TMVCRunOnRestServer.Create(self).
    SetCache('Default',cacheRootIfNoSession,15);
end;

procedure TAppWebMVC.Default(var Scope: variant);
begin

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
