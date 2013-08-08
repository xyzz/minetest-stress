return {
  ["statsfile"] = "luacov.stats.out",
  ["reportfile"] = "luacov.report.out",
  runreport = false,
  deletestats = false,
  ["include"] = {
    "games%.minimal%.mods%.stress",
  },
  ["exclude"] = {
    "games%.minimal%.mods%.stress%.tests",
  }
}
