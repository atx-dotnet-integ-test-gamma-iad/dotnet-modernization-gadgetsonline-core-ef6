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

Confirm that the output shows zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, confirm it references `Microsoft.NET.Sdk.Web`:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the URL shown in the console output and verify that the application loads and behaves as expected.

### 5. Run Existing Tests

If the solution contains test projects, execute them to validate that existing functionality has not regressed:

```bash
dotnet test
```

Review the test results and investigate any failures.

### 6. Check for Windows-Specific APIs

Even without build errors, the code may contain Windows-specific APIs that compile successfully but fail at runtime on non-Windows platforms. Search the codebase for usages such as:

- `System.Windows` namespaces
- `Microsoft.Win32` registry access
- Windows file path assumptions (e.g., hardcoded backslashes)
- `System.Drawing` (GDI+) which has limited cross-platform support

Replace any identified usages with cross-platform alternatives where applicable.

### 7. Verify Static Files and Configuration

If this is a web application, confirm the following:

- `appsettings.json` and `appsettings.{Environment}.json` are present and correctly configured.
- Connection strings point to accessible database instances.
- Any file paths referenced in configuration use `Path.Combine` or forward-slash notation for cross-platform compatibility.

### 8. Database Migrations

If the project uses Entity Framework Core, verify that migrations are up to date:

```bash
dotnet ef migrations list --project GadgetsOnline/GadgetsOnline.csproj
```

Apply any pending migrations to the target database:

```bash
dotnet ef database update --project GadgetsOnline/GadgetsOnline.csproj
```

### 9. Publish the Application

Once validation is complete, publish the application for the target platform:

```bash
dotnet publish GadgetsOnline/GadgetsOnline.csproj --configuration Release --output ./publish
```

Review the contents of the `./publish` directory and confirm all required files are present before deploying to the target environment.