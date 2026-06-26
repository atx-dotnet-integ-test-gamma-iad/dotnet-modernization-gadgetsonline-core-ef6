# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are restored correctly:

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

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure it targets `net8.0` or the appropriate version and that the project SDK is set to `Microsoft.NET.Sdk.Web`.

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the application in a browser and exercise the primary workflows to confirm they function as expected.

### 5. Run Existing Tests

If the solution contains test projects, execute them to validate that existing functionality has not regressed:

```bash
dotnet test
```

Review the test output for any failures and address them before proceeding.

### 6. Check for Windows-Specific APIs

Even with a successful build, some APIs may be Windows-specific and will fail at runtime on Linux or macOS. Search the codebase for any usage of the following:

- `Microsoft.Win32` namespace
- `System.Windows.Forms` or `System.Drawing` (non-cross-platform versions)
- Registry access (`RegistryKey`)
- Windows file path assumptions (e.g., hardcoded backslashes)

Replace any such usages with cross-platform alternatives where applicable.

### 7. Verify Configuration and Static Files

Confirm that configuration files such as `appsettings.json` are present and correctly structured. If the project previously used `Web.config`, verify that the relevant settings have been migrated to `appsettings.json` and are being read correctly via `IConfiguration`.

### 8. Check Database Connectivity

If the application uses a database, verify that the connection string in `appsettings.json` is correct for the target environment and that the database provider package (e.g., `Microsoft.EntityFrameworkCore.SqlServer`) is compatible with the target framework version.

### 9. Publish the Application

Once local validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files are present, then deploy the published output to the target environment.