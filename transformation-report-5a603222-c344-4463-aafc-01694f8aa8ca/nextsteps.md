# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore NuGet Packages

Run the following command from the solution root to ensure all dependencies are correctly restored:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages, deprecated package versions, or incompatible target frameworks.

### 2. Build the Solution

Perform a full build to confirm there are no compilation errors:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during the build, particularly those related to nullable reference types or obsolete APIs, as these may indicate compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version, such as `net8.0`. If it is set to an older version like `net5.0` or `net6.0`, consider updating it:

```xml
<TargetFramework>net8.0</TargetFramework>
```

After changing the target framework, re-run `dotnet restore` and `dotnet build`.

### 4. Run the Application Locally

Start the application to verify it runs without runtime errors:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key functionality to confirm expected behavior is preserved from the legacy version.

### 5. Run Existing Tests

If the solution contains test projects, execute them to validate functional correctness:

```bash
dotnet test
```

Review any failing tests and determine whether they represent regressions introduced during the migration or pre-existing issues.

### 6. Check for Removed or Changed APIs

Cross-platform .NET removes certain APIs that were available in .NET Framework. Use the .NET Upgrade Assistant compatibility analyzer or the `Microsoft.DotNet.PlatformAbstractions` tooling to identify any runtime-level API incompatibilities that may not surface as build errors:

```bash
dotnet tool install -g dotnet-compatibility
```

Pay particular attention to:
- `System.Web` dependencies, which are not available in cross-platform .NET
- Windows-specific registry or file path APIs
- Any use of `BinaryFormatter`, which is disabled by default in modern .NET

### 7. Verify Configuration Files

Confirm that `appsettings.json` (and environment-specific variants such as `appsettings.Development.json`) are present and correctly structured. Legacy `Web.config` or `App.config` settings should have been migrated to `appsettings.json` or environment variables.

### 8. Validate Static Files and wwwroot

If this is a web application, ensure that static assets (CSS, JavaScript, images) are located under the `wwwroot` folder and are being served correctly when the application runs.

### 9. Publish the Application

Once local validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files are present, then deploy the published output to the target environment.