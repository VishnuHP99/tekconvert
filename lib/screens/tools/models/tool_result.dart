class ToolResult {
  final double mainValue;
  final double? secondaryValue;
  final double? tertiaryValue;

  final String mainLabel;
  final String? secondaryLabel;
  final String? tertiaryLabel;

  const ToolResult({
    required this.mainValue,
    required this.mainLabel,
    this.secondaryValue,
    this.secondaryLabel,
    this.tertiaryValue,
    this.tertiaryLabel,
  });
}
