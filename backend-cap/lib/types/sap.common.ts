export type Locale = string;

export interface Languages {
    name: string;
    descr: string;
    code: Locale;
    texts?: LanguagesTexts[];
    localized?: LanguagesTexts;
}

export interface Countries {
    name: string;
    descr: string;
    code: string;
    texts?: CountriesTexts[];
    localized?: CountriesTexts;
}

export interface Currencies {
    name: string;
    descr: string;
    code: string;
    symbol: string;
    minorUnit: unknown;
    texts?: CurrenciesTexts[];
    localized?: CurrenciesTexts;
}

export interface LanguagesTexts {
    locale: Locale;
    name: string;
    descr: string;
    code: Locale;
}

export interface CountriesTexts {
    locale: Locale;
    name: string;
    descr: string;
    code: string;
}

export interface CurrenciesTexts {
    locale: Locale;
    name: string;
    descr: string;
    code: string;
}

export enum Entity {
    Languages = "sap.common.Languages",
    Countries = "sap.common.Countries",
    Currencies = "sap.common.Currencies",
    LanguagesTexts = "sap.common.Languages.texts",
    CountriesTexts = "sap.common.Countries.texts",
    CurrenciesTexts = "sap.common.Currencies.texts"
}

export enum SanitizedEntity {
    Languages = "Languages",
    Countries = "Countries",
    Currencies = "Currencies",
    LanguagesTexts = "LanguagesTexts",
    CountriesTexts = "CountriesTexts",
    CurrenciesTexts = "CurrenciesTexts"
}
