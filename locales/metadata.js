const localazyMetadata = {
  projectUrl: "https://localazy.com/p/wiki",
  baseLocale: "en",
  languages: [
    {
      language: "de",
      region: "",
      script: "",
      isRtl: false,
      name: "German",
      localizedName: "Deutsch",
      pluralType: (n) => { return (n===1) ? "one" : "other"; }
    },
    {
      language: "en",
      region: "",
      script: "",
      isRtl: false,
      name: "English",
      localizedName: "English",
      pluralType: (n) => { return (n===1) ? "one" : "other"; }
    },
    {
      language: "fr",
      region: "",
      script: "",
      isRtl: false,
      name: "French",
      localizedName: "Français",
      pluralType: (n) => { return (n===0 || n===1) ? "one" : "other"; }
    }
  ],
  files: [
    {
      cdnHash: "54b977214afbffe2ffeb07d0ccb03558e75e4408",
      file: "file.json",
      path: "",
      library: "",
      module: "",
      buildType: "",
      productFlavors: [],
      cdnFiles: {
        "de": "https://delivery.localazy.com/_a7797965569058078203416ae5aa/_e0/54b977214afbffe2ffeb07d0ccb03558e75e4408/de/file.json",
        "en": "https://delivery.localazy.com/_a7797965569058078203416ae5aa/_e0/54b977214afbffe2ffeb07d0ccb03558e75e4408/en/file.json",
        "fr": "https://delivery.localazy.com/_a7797965569058078203416ae5aa/_e0/54b977214afbffe2ffeb07d0ccb03558e75e4408/fr/file.json"
      }
    }
  ]
};

export default localazyMetadata;