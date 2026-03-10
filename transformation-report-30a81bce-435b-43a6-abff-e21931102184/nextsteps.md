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

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure the appropriate SDK is declared at the top of the project file:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the application in a browser and exercise the primary workflows to confirm expected behavior.

### 5. Run Existing Tests

If the solution contains test projects, execute them to validate that existing functionality has not regressed:

```bash
dotnet test
```

Review the test results and address any failing tests before proceeding.

### 6. Check for Windows-Specific API Usage

Even when a project builds successfully, it may contain APIs that are Windows-specific and will fail at runtime on other platforms. Use the .NET Compatibility Analyzer or review the code manually for usages such as:

- `Microsoft.Win32` namespace
- `System.Windows.Forms` or `System.Drawing` (non-web)
- Registry access
- Windows-specific file path assumptions (e.g., backslashes, drive letters)

Replace or abstract any such usages with cross-platform alternatives.

### 7. Verify Configuration and Static Files

If this is a web application, confirm the following:

- `appsettings.json` contains the correct connection strings and configuration values for the target environment.
- Static files (CSS, JavaScript, images) are located under `wwwroot` and are being served correctly.
- Any file path references in code use `Path.Combine` rather than hardcoded separators.

### 8. Database Migrations (If Applicable)

If the project uses Entity Framework, verify that migrations are up to date and apply them against the target database:

```bash
dotnet ef database update --project GadgetsOnline/GadgetsOnline.csproj
```

Confirm the schema matches expectations before running the application against a production or staging database.

### 9. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files are present, then deploy the output to the target environment according to your standard deployment process.