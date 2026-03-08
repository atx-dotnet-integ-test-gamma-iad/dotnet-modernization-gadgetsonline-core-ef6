# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no errors or warnings that may have been missed:

```bash
dotnet build --configuration Release
```

Address any warnings that surface, particularly those related to deprecated APIs or nullable reference types, as these can indicate areas of the code that may behave differently on cross-platform .NET compared to the original .NET Framework.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to an appropriate and supported version, such as `net8.0` or `net9.0`:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is set to an older version like `net6.0` or `net7.0`, consider upgrading to a Long-Term Support (LTS) release.

### 4. Check for Removed or Changed APIs

Review the codebase for any usage of APIs that were available in .NET Framework but have changed behavior or are no longer present in cross-platform .NET. Common areas to check include:

- `System.Web` references (not available in cross-platform .NET)
- `HttpContext` and related types (replaced by ASP.NET Core equivalents)
- `ConfigurationManager` (replaced by `Microsoft.Extensions.Configuration`)
- Windows-specific APIs such as the registry or certain `System.Drawing` types

The [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) can help identify these.

### 5. Run the Application Locally

Start the application and verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key workflows and confirm that core functionality behaves correctly.

### 6. Run Existing Tests

If the solution contains test projects, execute them to validate correctness:

```bash
dotnet test
```

Review any failing tests and determine whether they are caused by behavioral differences in cross-platform .NET or pre-existing issues.

### 7. Verify Static Assets and Configuration Files

Confirm that files such as `appsettings.json`, `wwwroot` assets, and any other configuration files have been correctly migrated. In particular:

- Connection strings should be moved from `Web.config` to `appsettings.json`
- Any `<appSettings>` entries should be migrated to the appropriate `appsettings.json` structure
- Ensure `Web.config` is no longer being relied upon for runtime configuration, as it is not used by cross-platform .NET in the same way

### 8. Test on Target Platforms

If cross-platform support is a goal, test the application on each intended operating system (e.g., Windows, Linux, macOS) to surface any platform-specific issues that may not appear during local development.