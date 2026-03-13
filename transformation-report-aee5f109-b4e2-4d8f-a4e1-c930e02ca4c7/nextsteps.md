# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

The transformation of your solution to cross-platform .NET appears to have completed successfully. No build errors were detected in any of the projects within the solution.

## Validation and Testing

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

### 2. Build the Solution

Perform a full solution build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the target framework is set to the intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the target framework does not match your intended version, update it accordingly and rebuild.

### 4. Run the Application Locally

Start the application locally to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the URL shown in the terminal output and verify the application loads correctly.

### 5. Review Runtime Behavior

Check the following areas manually at runtime, as these are common sources of issues after a cross-platform migration:

- **File paths**: Ensure no hardcoded Windows-style paths (e.g., `C:\`) exist in configuration files or code. Replace them with `Path.Combine` or relative paths.
- **Database connections**: Verify connection strings in `appsettings.json` or `web.config` are valid and accessible from the new environment.
- **Authentication and session handling**: Confirm that any authentication middleware is correctly configured for ASP.NET Core if the project was migrated from ASP.NET Framework.
- **Static files**: Ensure static assets (CSS, JS, images) are being served correctly via the `wwwroot` folder convention.

### 6. Run Existing Tests

If the solution contains test projects, execute them to validate core functionality:

```bash
dotnet test
```

Review any failing tests and address issues that may stem from API differences between .NET Framework and modern .NET.

### 7. Check for Removed or Changed APIs

Review the code for usage of APIs that were removed or significantly changed in modern .NET. The [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.UpgradeAssistant` tool can help identify remaining compatibility concerns:

```bash
dotnet tool install -g upgrade-assistant
upgrade-assistant analyze GadgetsOnline/GadgetsOnline.csproj
```

### 8. Validate Configuration System

If the project previously used `System.Configuration` (e.g., `ConfigurationManager.AppSettings`), confirm it has been migrated to the `Microsoft.Extensions.Configuration` system using `appsettings.json`. Ensure all expected keys and values are present and being read correctly at runtime.

### 9. Review Logging

If the project used a legacy logging framework or `System.Diagnostics.Trace`, confirm that logging has been updated to use `Microsoft.Extensions.Logging` or a compatible provider such as Serilog or NLog.