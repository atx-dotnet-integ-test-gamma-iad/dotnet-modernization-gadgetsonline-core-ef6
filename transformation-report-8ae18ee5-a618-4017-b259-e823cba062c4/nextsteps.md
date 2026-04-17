# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution

Perform a full build to confirm there are no errors or warnings that may have been missed:

```bash
dotnet build --configuration Release
```

Address any warnings that appear, particularly those related to nullable reference types, obsolete APIs, or platform compatibility.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Ensure this aligns with the runtime environment you intend to deploy to.

### 4. Run Unit Tests

If the solution contains test projects, execute the test suite to verify that existing functionality behaves as expected after the migration:

```bash
dotnet test --configuration Release
```

Review any failing tests and determine whether they are caused by behavioral differences in the new framework version.

### 5. Check for Windows-Specific APIs

Since this was a legacy project migration, review the codebase for any usage of Windows-specific APIs that may not be cross-platform. Common areas to check include:

- `System.Web` references (should be replaced with ASP.NET Core equivalents)
- Windows Registry access (`Microsoft.Win32.Registry`)
- Windows-only file path assumptions (e.g., backslash separators)
- `System.Drawing` (requires additional packages or replacements on non-Windows platforms)

Use the .NET Compatibility Analyzer to assist with this:

```bash
dotnet add package Microsoft.DotNet.Analyzers.Compatibility
```

### 6. Test Application Behavior Locally

Run the application locally and manually verify core functionality:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Walk through the primary user-facing features and confirm they behave as expected.

### 7. Review Configuration Files

Confirm that configuration files have been properly migrated:

- `web.config` settings should be moved to `appsettings.json` or `appsettings.{Environment}.json`
- Connection strings should be verified against the target database
- Any environment-specific settings should be reviewed for correctness

### 8. Verify Static Files and wwwroot

If this is a web project, ensure that static assets (CSS, JavaScript, images) are located in the `wwwroot` folder and are being served correctly by the application.

### 9. Database Connectivity

If the application uses a database, verify that the connection string is correct and that the application can connect and perform basic operations against the target database in the new environment.

### 10. Publish the Application

Once all validation steps pass, publish the application using:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to confirm all required files are present before deploying to the target environment.