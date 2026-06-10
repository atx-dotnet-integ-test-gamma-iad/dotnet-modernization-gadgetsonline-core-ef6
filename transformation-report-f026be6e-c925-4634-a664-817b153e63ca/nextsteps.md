# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to an appropriate modern .NET version, such as `net8.0`. Example:

```xml
<PropertyGroup>
  <TargetFramework>net8.0</TargetFramework>
</PropertyGroup>
```

If it is still targeting `net48` or another legacy framework, update it accordingly and re-run the build.

### 4. Run the Application Locally

Start the application to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the application in a browser and exercise the primary workflows to check for any runtime errors that would not surface at compile time.

### 5. Run Existing Tests

If the solution contains test projects, execute them to verify functional correctness:

```bash
dotnet test
```

Review the results for any failing tests and address them before proceeding.

### 6. Check for Removed or Changed APIs

Even with a clean build, some APIs behave differently on cross-platform .NET compared to .NET Framework. Pay particular attention to:

- **System.Web** dependencies: These are not available on cross-platform .NET. If any remain, they will need to be replaced with ASP.NET Core equivalents.
- **Windows-specific APIs**: Any usage of the Windows registry, `System.Drawing` (GDI+), or COM interop may require replacement or the addition of compatibility packages.
- **Configuration**: `web.config`-based configuration should be migrated to `appsettings.json` and the `Microsoft.Extensions.Configuration` model.
- **Entity Framework**: If the project uses Entity Framework 6, consider whether migration to Entity Framework Core is appropriate for your scenario.

### 7. Review Static Files and wwwroot

Confirm that static assets (CSS, JavaScript, images) have been placed under the `wwwroot` folder, which is the expected location for static files in ASP.NET Core.

### 8. Verify Database Connectivity

If the application uses a database, confirm that connection strings in `appsettings.json` are correct and that the application can connect and perform basic operations against the database in the target environment.

### 9. Publish the Application

Once local validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` folder to ensure all expected files are present, then deploy the published output to your target environment.