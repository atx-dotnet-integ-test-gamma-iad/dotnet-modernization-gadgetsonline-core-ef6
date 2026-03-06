# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore NuGet Packages

Before running or testing the project, ensure all dependencies are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Solution

Perform a full build to confirm there are no errors or warnings that may have been missed:

```bash
dotnet build --configuration Release
```

Address any warnings that appear, particularly those related to deprecated APIs or target framework compatibility.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the target framework is set to the intended cross-platform version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Ensure this aligns with your intended deployment environment.

### 4. Check for Runtime Dependencies

Some libraries that compiled successfully may still have runtime issues. Review the following:

- Any use of `System.Web` namespaces, which are not available on cross-platform .NET. These should have been replaced with `Microsoft.AspNetCore` equivalents.
- Windows-specific APIs (e.g., registry access, Windows identity) that may compile but fail at runtime on non-Windows platforms.
- Any third-party NuGet packages that may have been targeting .NET Framework. Verify they have compatible versions for the new target framework.

### 5. Run the Application Locally

Start the application and verify it runs without runtime exceptions:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's core functionality and confirm expected behavior.

### 6. Execute Existing Tests

If the solution contains test projects, run them to validate that existing functionality has not regressed:

```bash
dotnet test
```

Review test output and investigate any failures.

### 7. Review Configuration Files

- Confirm that `appsettings.json` (or equivalent) contains all configuration values previously held in `web.config` or `app.config`.
- Verify connection strings, API keys, and environment-specific settings are correctly migrated.
- If `web.config` transforms were used previously, ensure those settings are now handled through the `appsettings.{Environment}.json` pattern or environment variables.

### 8. Validate Static Assets and Middleware

If this is a web application, verify:

- Static files (CSS, JavaScript, images) are being served correctly.
- Middleware components such as authentication, authorization, and routing are functioning as expected.
- Any HTTP handlers or modules from the legacy project have been properly replaced with ASP.NET Core middleware.

### 9. Publish the Application

Once local validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files are present before deploying to the target environment.