/// Kingdom Users Core Objects Tests
// - this unit is a part of the freeware Synopse Basilique framework,
// licensed under a GPL v3 license
unit KdomObjUserTests;

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
  - first public release of the Basilique Frameork

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
  SynCrypto;

type

  { TTestUserKingdom }

  TTestUserKingdom = class(TSynTestCase)
  published
    procedure UserSecurity;
  end;


implementation

uses
  KdomObjUser;

{ TTestUserKingdom }

procedure TTestUserKingdom.UserSecurity;
var
  u: TSQLUserAuth;
  i: integer;
  p: RawUTF8;
begin
  u := TSQLUserAuth.Create;
  try
    check(not u.SetPassword('has spaces'));
    check(not u.SetPassword(' hasspaces'));
    check(not u.SetPassword('has'#9'spaces'));
    for i := 0 to 100 do begin
      p := TAESPRNG.Main.RandomPassword(i);
      check(u.SetPassword(p) = (i >= 8));
      if i < 8 then
        continue;
      check(u.MatchPassword(p));
      check(not u.MatchPassword(p + 'a'));
      check(not u.MatchPassword(copy(p, 1, i - 1)));
      dec(p[i - 2]);
      check(not u.MatchPassword(p));
      inc(p[i - 2]);
      check(u.MatchPassword(p));
    end;
  finally
    u.Free;
  end;
end;

initialization
end.
