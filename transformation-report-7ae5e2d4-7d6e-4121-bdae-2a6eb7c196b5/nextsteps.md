# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore NuGet Packages

Before running or testing the project, ensure all dependencies are restored correctly.

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts. Resolve any that appear before proceeding.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean build environment.

```bash
dotnet build --configuration Release
```

Confirm that the output reports zero errors and review any warnings, as some warnings may indicate deprecated APIs or compatibility concerns that could cause runtime issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Refer to the [.NET support policy](https://dotnet.microsoft.com/en-us/platform/support/policy) to ensure you are targeting an actively supported version.

### 4. Check for Removed or Changed APIs

Even without build errors, some APIs that existed in .NET Framework may behave differently or have been replaced in cross-platform .NET. Review the following areas specifically:

- **`System.Web` dependencies**: These are not available in cross-platform .NET. If any were present in the original project, confirm they have been replaced with appropriate ASP.NET Core equivalents.
- **Configuration**: Ensure `web.config`-based configuration has been migrated to `appsettings.json` and the `IConfiguration` pattern.
- **HTTP pipeline**: Verify that any HTTP modules or handlers have been converted to ASP.NET Core middleware.

### 5. Run the Application Locally

Start the application using the .NET CLI and verify it runs without runtime exceptions.

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the application in a browser and exercise the primary workflows to identify any runtime errors that would not surface at build time.

### 6. Review Application Logs

Check the console output and any configured log sinks for exceptions or warnings during startup and normal operation. Pay particular attention to:

- Middleware configuration errors
- Database connection issues
- Missing configuration values

### 7. Execute Existing Tests

If the solution contains test projects, run them to verify functional correctness.

```bash
dotnet test
```

Review any failing tests and address them before considering the migration complete.

### 8. Validate Data Access Layer

If the project uses Entity Framework, confirm the version being used is compatible with cross-platform .NET and that any migrations are up to date.

```bash
dotnet ef migrations list --project GadgetsOnline/GadgetsOnline.csproj
```

Apply any pending migrations to a development database and verify the schema is correct.

### 9. Test on Target Operating Systems

Since the goal is cross-platform compatibility, run the application on each operating system you intend to support (Windows, Linux, macOS) and confirm consistent behavior across all of them.

### 10. Publish the Application

Once validation is complete, publish the application to confirm the output is as expected.

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files are present before deploying to the target environment.