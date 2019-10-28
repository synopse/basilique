/// Kingdom Text Core Objects
// - this unit is a part of the freeware Synopse Basilique framework,
// licensed under a GPL v3 license
unit KdomObjText;

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
  mORMot;

type
  // supported languages for Text content
  TTextLanguage = (
    tlDari, tlBosnian, tlCatalan, tlCorsican, tlCzech, tlCoptic,
    tlSlavic, tlWelsh, tlDanish, tlGerman, tlHebrew, tlGreek, tlLatin,
    tlArabic, tlEnglish, tlSpanish, tlFarsi, tlFinnish,
    tlFrench, tlIrish, tlGaelic, tlAramaic, tlCroatian, tlHungarian,
    tlArmenian, tlIndonesian, tlInterlingue, tlIcelandic, tlItalian,
    tlJapanese, tlKorean, tlTibetan, tlLituanian, tlMalgash, tlNorwegian,
    tlOccitan, tlPortuguese, tlPolish, tlRomanian, tlRussian, tlSanskrit,
    tlSlovak, tlSlovenian, tlAlbanian, tlSerbian, tlSwedish, tlSyriac,
    tlTurkish, tlTahitian, tlUkrainian, tlVietnamese, tlChinese, tlDutch,
    tlThai, tlBulgarian, tlBelarusian, tlEstonian, tlLatvian, tlMacedonian,
    tlPashtol );
 /// allows to display text in preference order for TTextPreferences
 TTextLanguageDynArray = array of TTextLanguage;

const
  /// ISO 639-1 compatible abbreviations (not to be translated):
  TextLanguageAbr: packed array[TTextLanguage] of RawUTF8 = (
    'ad','bs','ca','co','cs','cp','cu','cy','da','de','he','gr','la','ar',
    'en','es','fa','fi','fr','ga','gd','am','hr','hu','hy','id','ie','is',
    'it','ja','ko','bo','lt','mg','no','oc','pt','pl','ro','ru','sa','sk',
    'sl','sq','sr','sv','sy','tr','ty','uk','vi','zh','nl',
    'th','bg','be','et','lv','mk','ap');


implementation


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
