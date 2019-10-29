/// Kingdom User Registration Core Services implementation
// - this unit is a part of the freeware Synopse Basilique framework,
// licensed under a GPL v3 license
unit KdomServRegister;

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
  KdomObjUser,
  KdomObjCommunity,
  KdomServUserAPI; // define Kingdom API interfaces


type
  TServiceRegister = class(TInjectableObjectRest, IRegister)
  protected
    // IRegister methods
    function NewUser(const name, email, plainpassword: RawUTF8; out user: TUserID): TRegisterResult;
  end;


implementation

{ TServiceRegister  }

function TServiceRegister.NewUser(const name, email, plainpassword: RawUTF8;
  out user: TUserID): TRegisterResult;
var
  u: TSQLUser;
  ua: TSQLUserAuth;
begin
  result := rrUserNameTooWeak;
  if (length(name) < 4) then
    exit;
  result := rrUserEmailInvalid;
  if not IsValidEmail(pointer(email)) then
    exit;
  ua := TSQLUserAuth.Create;
  try
    result := rrUserEmailAlreadyExists;
    if not fServer.Retrieve('email=?', [], [email], ua) then
      exit;
    result := rrWeakPassword;
    if not ua.SetPassword(plainpassword) then
      exit;
    result := rrInternalError;
    u := TSQLUser.Create;
    try
      u.name := name;
      u.email := email;
      { TODO : use system-wide genuine TUserID }
      user := fServer.Add(u, true);
      if user <> 0 then begin
        ua.IDValue := user;
        ua.email := email;
        if fServer.Add(ua, true, true) <> 0 then
          result := rrSuccess
        else // rollback User on UserAuth writing problem (unlikely)
          fServer.Delete(TSQLUser, u.IDValue);
      end;
    finally
      u.Free;
    end;
  finally
    ua.Free;
  end;
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
