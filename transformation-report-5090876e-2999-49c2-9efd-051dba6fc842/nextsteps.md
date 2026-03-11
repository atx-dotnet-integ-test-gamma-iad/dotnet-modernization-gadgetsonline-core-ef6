# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The solution build output contains no errors for the transformed project (`GadgetsOnline/GadgetsOnline.csproj`). This indicates the migration to cross-platform .NET has completed without any compilation issues.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to confirm all NuGet packages resolve correctly:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts and resolve them before proceeding.

### 2. Build the Solution

Perform a full build to confirm the clean state:

```bash
dotnet build --configuration Release
```

Confirm that the output reports zero errors and zero warnings, or review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended .NET version (e.g., `net8.0`). Ensure this aligns with the runtime environment you intend to deploy to.

### 4. Run Unit Tests

If the solution contains test projects, execute them to verify that existing functionality is preserved after the transformation:

```bash
dotnet test --configuration Release
```

Review any failing tests and determine whether they are caused by behavioral differences between the legacy .NET Framework and the new .NET runtime.

### 5. Check for Runtime-Only Issues

Some issues do not surface at compile time. Start the application locally and exercise the main workflows:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Pay particular attention to the following areas that commonly differ between .NET Framework and cross-platform .NET:

- **Configuration**: Ensure `web.config` or `app.config` settings have been migrated to `appsettings.json` and are being read correctly via `IConfiguration`.
- **HTTP pipeline**: If this is an ASP.NET project, confirm that middleware, routing, and authentication are functioning as expected under the new ASP.NET Core pipeline.
- **Database access**: Verify that any Entity Framework or ADO.NET calls execute correctly and that connection strings are properly configured.
- **File paths**: Confirm that any file I/O operations use `Path.Combine` and relative paths rather than hardcoded Windows-style paths.
- **Globalization**: .NET 6 and later changed default globalization behavior. If you encounter issues with string comparisons or culture-specific formatting, review the `System.Globalization.UseNls` runtime configuration switch.

### 6. Review Removed or Changed APIs

Cross-reference the project's code against the [.NET Compatibility Analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/net-framework-tech-unavailable) documentation to identify any APIs that were available in .NET Framework but are absent or changed in modern .NET. Common areas include:

- `System.Web` dependencies (must be replaced with ASP.NET Core equivalents)
- `AppDomain` usage
- Binary serialization (`BinaryFormatter` is disabled by default)
- WCF client/server usage

### 7. Validate Static Assets and Views

If the project is a web application, manually verify that all views render correctly, static files are served, and any bundling or minification configurations have been updated to use the ASP.NET Core conventions.

### 8. Review Logging and Error Handling

Confirm that logging has been migrated from any legacy providers (e.g., `log4net`, `NLog` configured via XML) to the `Microsoft.Extensions.Logging` abstraction or that the legacy provider is correctly integrated with it.