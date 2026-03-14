# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in the solution. The project `GadgetsOnline/GadgetsOnline.csproj` compiled without issues.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution

Perform a full build to confirm the error-free state is consistent:

```bash
dotnet build --configuration Release
```

Check the output for any warnings that, while non-blocking, may indicate compatibility concerns with the target framework.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to your intended cross-platform .NET version (e.g., `net8.0`):

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is still referencing `net48` or any other legacy .NET Framework moniker, update it accordingly and rebuild.

### 4. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key workflows to verify runtime behavior matches the pre-migration state.

### 5. Run Existing Tests

If the solution contains test projects, execute them to validate functional correctness:

```bash
dotnet test
```

Review any failing tests and determine whether failures are caused by migration-related changes or pre-existing issues.

### 6. Check for Removed or Changed APIs

Even without build errors, some APIs behave differently on cross-platform .NET compared to .NET Framework. Pay particular attention to:

- **`System.Web` dependencies**: These are not available on cross-platform .NET. If any were referenced, confirm they have been replaced with ASP.NET Core equivalents.
- **Windows-specific APIs**: If the application uses registry access, Windows-specific file paths, or COM interop, those areas require additional attention when running on non-Windows platforms.
- **Entity Framework**: If the project uses Entity Framework 6, confirm it has been migrated to Entity Framework Core or that the EF6 cross-platform NuGet package is in use.
- **Configuration**: Confirm that `web.config` or `app.config` based configuration has been replaced with `appsettings.json` and the `Microsoft.Extensions.Configuration` model.

### 7. Static Analysis

Run a .NET upgrade compatibility analyzer to surface any remaining compatibility concerns:

```bash
dotnet add package Microsoft.DotNet.UpgradeAssistant.Extensions.Default.Analyzers
dotnet build
```

Review any analyzer diagnostics and address them as appropriate.

### 8. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Verify the contents of the `./publish` directory and confirm the application runs from the published output before deploying to the target environment.