export const INFISICAL_LANGUAGES = [
  { code: "en", label: "English" },
  { code: "zh-TW", label: "繁體中文（台灣）" },
  { code: "ko", label: "한국어" },
  { code: "fr", label: "Français" },
  { code: "es", label: "Español" },
  { code: "pt-BR", label: "Português (Brasil)" },
  { code: "tr", label: "Türkçe" }
] as const;

export type InfisicalLanguageCode = (typeof INFISICAL_LANGUAGES)[number]["code"];

export const INFISICAL_LANG_STORAGE_KEY = "infisical-ui-lang";

export function resolveInitialLanguage(): InfisicalLanguageCode {
  if (typeof window === "undefined") {
    return "en";
  }

  const stored = localStorage.getItem(INFISICAL_LANG_STORAGE_KEY);
  if (stored && INFISICAL_LANGUAGES.some((l) => l.code === stored)) {
    return stored as InfisicalLanguageCode;
  }

  const nav = navigator.language.toLowerCase();
  if (nav.startsWith("zh-tw") || nav === "zh-hant") {
    return "zh-TW";
  }
  if (nav.startsWith("zh")) {
    return "zh-TW";
  }

  return "en";
}
