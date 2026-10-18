import { useTranslation } from "react-i18next";

import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue
} from "@app/components/v3";
import {
  INFISICAL_LANGUAGES,
  INFISICAL_LANG_STORAGE_KEY,
  type InfisicalLanguageCode
} from "@app/lib/i18n/languages";

export const LanguageSection = () => {
  const { i18n, t } = useTranslation();
  const resolved = i18n.resolvedLanguage ?? i18n.language;
  const current = INFISICAL_LANGUAGES.some((l) => l.code === resolved)
    ? (resolved as InfisicalLanguageCode)
    : "en";

  const onChange = (code: string) => {
    const lang = code as InfisicalLanguageCode;
    localStorage.setItem(INFISICAL_LANG_STORAGE_KEY, lang);
    void i18n.changeLanguage(lang);
  };

  return (
    <Card>
      <CardHeader>
        <CardTitle>{t("settings.personal.change-language")}</CardTitle>
        <CardDescription>{t("settings.personal.change-language-hint")}</CardDescription>
      </CardHeader>
      <CardContent>
        <Select value={current ?? "en"} onValueChange={onChange}>
          <SelectTrigger className="max-w-xs" aria-label={t("common.language")}>
            <SelectValue placeholder={t("common.language")} />
          </SelectTrigger>
          <SelectContent>
            {INFISICAL_LANGUAGES.map(({ code, label }) => (
              <SelectItem key={code} value={code}>
                {label}
              </SelectItem>
            ))}
          </SelectContent>
        </Select>
      </CardContent>
    </Card>
  );
};
