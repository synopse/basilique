/// Kingdom Users Core Objects
// - this unit is a part of the freeware Synopse Basilique framework,
// licensed under a GPL v3 license
unit KdomObjUser;

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


(*************** some shared high-level type definitions **************)

type
  TEmail = type RawUTF8;
  TEmailDynArray = array of TEmail;

  /// Country identifiers, following ISO 3166-1 standard
  TCountryIdentifier = (ccUndefined,
    ccAF,ccAX,ccAL,ccDZ,ccAS,ccAD,ccAO,ccAI,ccAQ,ccAG,ccAR,ccAM,ccAW,ccAU,ccAT,
    ccAZ,ccBS,ccBH,ccBD,ccBB,ccBY,ccBE,ccBZ,ccBJ,ccBM,ccBT,ccBO,ccBQ,ccBA,ccBW,
    ccBV,ccBR,ccIO,ccBN,ccBG,ccBF,ccBI,ccKH,ccCM,ccCA,ccCV,ccKY,ccCF,ccTD,ccCL,
    ccCN,ccCX,ccCC,ccCO,ccKM,ccCG,ccCD,ccCK,ccCR,ccCI,ccHR,ccCU,ccCW,ccCY,ccCZ,
    ccDK,ccDJ,ccDM,ccDO,ccEC,ccEG,ccSV,ccGQ,ccER,ccEE,ccET,ccFK,ccFO,ccFJ,ccFI,
    ccFR,ccGF,ccPF,ccTF,ccGA,ccGM,ccGE,ccDE,ccGH,ccGI,ccGR,ccGL,ccGD,ccGP,ccGU,
    ccGT,ccGG,ccGN,ccGW,ccGY,ccHT,ccHM,ccVA,ccHN,ccHK,ccHU,ccIS,ccIN,ccID,ccIR,
    ccIQ,ccIE,ccIM,ccIL,ccIT,ccJM,ccJP,ccJE,ccJO,ccKZ,ccKE,ccKI,ccKP,ccKR,ccKW,
    ccKG,ccLA,ccLV,ccLB,ccLS,ccLR,ccLY,ccLI,ccLT,ccLU,ccMO,ccMK,ccMG,ccMW,ccMY,
    ccMV,ccML,ccMT,ccMH,ccMQ,ccMR,ccMU,ccYT,ccMX,ccFM,ccMD,ccMC,ccMN,ccME,ccMS,
    ccMA,ccMZ,ccMM,ccNA,ccNR,ccNP,ccNL,ccNC,ccNZ,ccNI,ccNE,ccNG,ccNU,ccNF,ccMP,
    ccNO,ccOM,ccPK,ccPW,ccPS,ccPA,ccPG,ccPY,ccPE,ccPH,ccPN,ccPL,ccPT,ccPR,ccQA,
    ccRE,ccRO,ccRU,ccRW,ccBL,ccSH,ccKN,ccLC,ccMF,ccPM,ccVC,ccWS,ccSM,ccST,ccSA,
    ccSN,ccRS,ccSC,ccSL,ccSG,ccSX,ccSK,ccSI,ccSB,ccSO,ccZA,ccGS,ccSS,ccES,ccLK,
    ccSD,ccSR,ccSJ,ccSZ,ccSE,ccCH,ccSY,ccTW,ccTJ,ccTZ,ccTH,ccTL,ccTG,ccTK,ccTO,
    ccTT,ccTN,ccTR,ccTM,ccTC,ccTV,ccUG,ccUA,ccAE,ccGB,ccUS,ccUM,ccUY,ccUZ,ccVU,
    ccVE,ccVN,ccVG,ccVI,ccWF,ccEH,ccYE,ccZM,ccZW);
  /// stores a ISO 3166-1 alpha-2 code of a country
  TCountryIdentifier2 = type RawUTF8;
  /// stores a ISO 3166-1 alpha-3 code of a country
  TCountryIdentifier3 = type RawUTF8;


const
  /// the English text corresponding to each ISO 3166-1 country
  COUNTRY_NAME_EN: array[TCountryIdentifier] of RawUTF8 = ('',
    'Afghanistan','Aland Islands','Albania','Algeria','American Samoa',
    'Andorra','Angola','Anguilla','Antarctica','Antigua and Barbuda',
    'Argentina','Armenia','Aruba','Australia','Austria','Azerbaijan',
    'Bahamas','Bahrain','Bangladesh','Barbados','Belarus','Belgium',
    'Belize','Benin','Bermuda','Bhutan','Bolivia, Plurinational State of',
    'Bonaire, Sint Eustatius and Saba','Bosnia and Herzegovina','Botswana',
    'Bouvet Island','Brazil','British Indian Ocean Territory',
    'Brunei Darussalam','Bulgaria','Burkina Faso','Burundi','Cambodia',
    'Cameroon','Canada','Cape Verde','Cayman Islands','Central African Republic',
    'Chad','Chile','China','Christmas Island','Cocos (Keeling) Islands',
    'Colombia','Comoros','Congo','Congo, the Democratic Republic of the',
    'Cook Islands','Costa Rica','Ivory Coast','Croatia','Cuba','Curacao',
    'Cyprus','Czech Republic','Denmark','Djibouti','Dominica',
    'Dominican Republic','Ecuador','Egypt','El Salvador','Equatorial Guinea',
    'Eritrea','Estonia','Ethiopia','Falkland Islands (Malvinas)',
    'Faroe Islands','Fiji','Finland','France','French Guiana',
    'French Polynesia','French Southern Territories','Gabon','Gambia','Georgia',
    'Germany','Ghana','Gibraltar','Greece','Greenland','Grenada','Guadeloupe',
    'Guam','Guatemala','Guernsey','Guinea','Guinea-Bissau','Guyana','Haiti',
    'Heard Island and McDonald Islands','Holy See (Vatican City State)',
    'Honduras','Hong Kong','Hungary','Iceland','India','Indonesia',
    'Iran, Islamic Republic of','Iraq','Ireland','Isle of Man','Israel',
    'Italy','Jamaica','Japan','Jersey','Jordan','Kazakhstan','Kenya',
    'Kiribati','Korea, Democratic People''s Republic of','Korea, Republic of',
    'Kuwait','Kyrgyzstan','Lao People''s Democratic Republic','Latvia',
    'Lebanon','Lesotho','Liberia','Libyan Arab Jamahiriya','Liechtenstein',
    'Lithuania','Luxembourg','Macao','Macedonia, the former Yugoslav Republic of',
    'Madagascar','Malawi','Malaysia','Maldives','Mali','Malta','Marshall Islands',
    'Martinique','Mauritania','Mauritius','Mayotte','Mexico',
    'Micronesia, Federated States of','Moldova, Republic of','Monaco',
    'Mongolia','Montenegro','Montserrat','Morocco','Mozambique','Myanmar',
    'Namibia','Nauru','Nepal','Netherlands','New Caledonia','New Zealand',
    'Nicaragua','Niger','Nigeria','Niue','Norfolk Island',
    'Northern Mariana Islands','Norway','Oman','Pakistan','Palau',
    'Palestinian Territory','Panama','Papua New Guinea','Paraguay','Peru',
    'Philippines','Pitcairn','Poland','Portugal','Puerto Rico','Qatar',
    'Reunion','Romania','Russian Federation','Rwanda','Saint Barthelemy',
    'Saint Helena, Ascension and Tristan da Cunha','Saint Kitts and Nevis',
    'Saint Lucia','Saint Martin (French part)','Saint Pierre and Miquelon',
    'Saint Vincent and the Grenadines','Samoa','San Marino',
    'Sao Tome and Principe','Saudi Arabia','Senegal','Serbia',
    'Seychelles','Sierra Leone','Singapore','Sint Maarten (Dutch part)',
    'Slovakia','Slovenia','Solomon Islands','Somalia','South Africa',
    'South Georgia and the South Sandwich Islands','South Sudan','Spain',
    'Sri Lanka','Sudan','Suriname','Svalbard and Jan Mayen','Swaziland',
    'Sweden','Switzerland','Syrian Arab Republic','Taiwan, Province of China',
    'Tajikistan','Tanzania, United Republic of','Thailand','Timor-Leste',
    'Togo','Tokelau','Tonga','Trinidad and Tobago','Tunisia','Turkey',
    'Turkmenistan','Turks and Caicos Islands','Tuvalu','Uganda','Ukraine',
    'United Arab Emirates','United Kingdom','United States',
    'United States Minor Outlying Islands','Uruguay','Uzbekistan','Vanuatu',
    'Venezuela, Bolivarian Republic of','Viet Nam','Virgin Islands, British',
    'Virgin Islands, U.S.','Wallis and Futuna','Western Sahara','Yemen',
    'Zambia','Zimbabwe');

  /// the ISO 3166-1 alpha-3 codes of each country
  COUNTRY_ISO3: array[TCountryIdentifier] of TCountryIdentifier3 = ('',
    'AFG','ALA','ALB','DZA','ASM','AND','AGO','AIA','ATA','ATG','ARG','ARM',
    'ABW','AUS','AUT','AZE','BHS','BHR','BGD','BRB','BLR','BEL','BLZ','BEN',
    'BMU','BTN','BOL','BES','BIH','BWA','BVT','BRA','IOT','BRN','BGR','BFA',
    'BDI','KHM','CMR','CAN','CPV','CYM','CAF','TCD','CHL','CHN','CXR','CCK',
    'COL','COM','COG','COD','COK','CRI','CIV','HRV','CUB','CUW','CYP','CZE',
    'DNK','DJI','DMA','DOM','ECU','EGY','SLV','GNQ','ERI','EST','ETH','FLK',
    'FRO','FJI','FIN','FRA','GUF','PYF','ATF','GAB','GMB','GEO','DEU','GHA',
    'GIB','GRC','GRL','GRD','GLP','GUM','GTM','GGY','GIN','GNB','GUY','HTI',
    'HMD','VAT','HND','HKG','HUN','ISL','IND','IDN','IRN','IRQ','IRL','IMN',
    'ISR','ITA','JAM','JPN','JEY','JOR','KAZ','KEN','KIR','PRK','KOR','KWT',
    'KGZ','LAO','LVA','LBN','LSO','LBR','LBY','LIE','LTU','LUX','MAC','MKD',
    'MDG','MWI','MYS','MDV','MLI','MLT','MHL','MTQ','MRT','MUS','MYT','MEX',
    'FSM','MDA','MCO','MNG','MNE','MSR','MAR','MOZ','MMR','NAM','NRU','NPL',
    'NLD','NCL','NZL','NIC','NER','NGA','NIU','NFK','MNP','NOR','OMN','PAK',
    'PLW','PSE','PAN','PNG','PRY','PER','PHL','PCN','POL','PRT','PRI','QAT',
    'REU','ROU','RUS','RWA','BLM','SHN','KNA','LCA','MAF','SPM','VCT','WSM',
    'SMR','STP','SAU','SEN','SRB','SYC','SLE','SGP','SXM','SVK','SVN','SLB',
    'SOM','ZAF','SGS','SSD','ESP','LKA','SDN','SUR','SJM','SWZ','SWE','CHE',
    'SYR','TWN','TJK','TZA','THA','TLS','TGO','TKL','TON','TTO','TUN','TUR',
    'TKM','TCA','TUV','UGA','UKR','ARE','GBR','USA','UMI','URY','UZB','VUT',
    'VEN','VNM','VGB','VIR','WLF','ESH','YEM','ZMB','ZWE');

var
  /// the ISO 3166-1 alpha-2 codes of each country
  COUNTRY_ISO2: array[TCountryIdentifier] of TCountryIdentifier2;


type
  /// address how to contact an User or Organization
  TAddress = class(TSynPersistent)
  private
    fIdent: RawUTF8;
    fStreet1, fStreet2: RawUTF8;
    fCity: RawUTF8;
    fCountry: TCountryIdentifier;
    fZip: RawUTF8;
  published
    property ident: RawUTF8 read fIdent;
    property street1: RawUTF8 read fStreet1;
    property street2: RawUTF8 read fStreet2;
    property zip: RawUTF8 read fZip;
    property city: RawUTF8 read fCity;
    property country: TCountryIdentifier read fCountry;
  end;
  TAddressObjArray = array of TAddress;


(*************** User Kingdom Value Objects and Entities ******************)

type
  /// supported languages for TUserPreferences
  // - i.e. mainly
  TUserLanguage = (ulEnglish, ulSpanish, ulFrench, ulItalian);

  /// User-specific way of doing things
  // - some fields are hardcoded as enumerates, some are just
  // serialized as a TDocVariant
  TUserPreferences = class(TSynAutoCreateFields)
  protected
    fIdent: RawUTF8;
    fCustom: variant; // TDocVariantData object, stored as JSON
    fLanguage: TUserLanguage;
  published
    property ident: RawUTF8 read fIdent;
    property language: TUserLanguage read fLanguage write fLanguage;
    property custom: variant read fCustom write fCustom;
  end;
  TUserPreferencesObjArray = array of TUserPreferences;

  /// 64-bit system-wide User identifier - matches TSQLUser.ID and TSQLUserAuth.ID
  TUserID = type TID;

  TUserRight = (canReadTexts, canReadCommunities, canReadUserInfo,
    canReadThread, canWriteThread, canReadNote, canWriteNote);
  TUserRights = set of TUserRight;


(*************** User Kingdom Aggregates ******************)

type
  /// general User information Aggregaate
  // - ID is a 64-bit TUsedID
  // - bounded context: User preferences
  TSQLUser = class(TSQLRecordNoCaseExtended)
  protected
    fEmail: TEmailDynArray;
    fAddress: TAddressObjArray;
    fPreferences: TUserPreferencesObjArray;
  published
    property Email: TEmailDynArray read fEmail;
    property Address: TAddressObjArray read fAddress;
    property Preferences: TUserPreferencesObjArray read fPreferences;
  end;


implementation

procedure InitializeConstants;
begin
  GetEnumTrimmedNames(TypeInfo(TCountryIdentifier), @COUNTRY_ISO2);
  COUNTRY_ISO2[ccUndefined] := '';
end;



initialization
  InitializeConstants;
  TTextWriter.RegisterCustomJSONSerializerFromTextSimpleType([
    ]);
  TTextWriter.RegisterCustomJSONSerializerFromTextBinaryType([
    ]);
  TTextWriter.RegisterCustomJSONSerializerFromText([
    ]);
  TJSONSerializer.RegisterObjArrayForJSON([
    TypeInfo(TAddressObjArray), TAddress]);
  TInterfaceFactory.RegisterInterfaces([
    ]);
end.
