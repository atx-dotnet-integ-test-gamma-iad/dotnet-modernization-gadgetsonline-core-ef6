# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in the solution. The project `GadgetsOnline/GadgetsOnline.csproj` compiled without issues.

## Validation

### 1. Restore Dependencies

Run the following command from the solution root to confirm all NuGet packages resolve correctly:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Solution

Perform a full build to confirm the error-free state is consistent:

```bash
dotnet build --configuration Release
```

Check the output for any warnings that, while non-blocking, may indicate deprecated APIs or compatibility concerns that could cause runtime issues.

### 3. Run Unit Tests

If the solution contains test projects, execute them to verify runtime behavior has not regressed:

```bash
dotnet test --configuration Release
```

Review test results and address any failures before proceeding.

### 4. Run the Application Locally

Start the application locally to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Walk through the core application workflows manually to confirm expected behavior, particularly around:

- Database connectivity and Entity Framework migrations (if applicable)
- Authentication and session handling
- Any file system or path-dependent operations that may behave differently across operating systems

### 5. Check for Platform-Specific Code

Even without build errors, review the codebase for any remaining platform-specific patterns that may cause runtime failures on non-Windows systems:

- Usage of `System.Web` types that may have been shimmed during transformation
- Windows registry access
- Hardcoded Windows-style file paths using backslashes
- COM interop or P/Invoke calls targeting Windows libraries

### 6. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `TargetFramework` is set to an appropriate and currently supported version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is targeting an older version such as `net5.0` or `net6.0`, consider updating to a long-term support (LTS) release.

### 7. Review Configuration Files

Confirm that configuration has been properly migrated from `Web.config` or `App.config` to the `appsettings.json` pattern used in modern .NET:

- Connection strings
- Application settings
- Logging configuration
- Environment-specific overrides via `appsettings.Development.json` and `appsettings.Production.json`

### 8. Publish the Application

Once local validation is complete, produce a published output:

```bash
dotnet publish GadgetsOnline/GadgetsOnline.csproj --configuration Release --output ./publish
```

Verify the contents of the `./publish` directory and confirm the application starts correctly from that output using:

```bash
dotnet ./publish/GadgetsOnline.dll
```