# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The solution build output contains no errors for the transformed project (`GadgetsOnline/GadgetsOnline.csproj`). This indicates the migration to cross-platform .NET has completed without introducing any compilation issues.

## Validation Steps

### 1. Restore and Build the Solution

Run the following commands from the solution root to confirm a clean restore and build:

```bash
dotnet restore
dotnet build --configuration Release
```

Ensure both commands complete with no errors or warnings that could indicate missing dependencies or incompatible package versions.

### 2. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element targets the intended cross-platform .NET version (e.g., `net8.0`):

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it still references a Windows-only TFM such as `net48`, the migration may be incomplete.

### 3. Check for Runtime Dependencies

Review any remaining references to Windows-specific APIs or libraries, such as:

- `System.Web` (not available on cross-platform .NET)
- `Microsoft.Web.*` packages
- Windows Registry access
- COM interop

Replace or remove any such dependencies with cross-platform equivalents.

### 4. Run the Application Locally

Start the application and verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and confirm that all major features function correctly, including any database connections, authentication flows, and page rendering.

### 5. Run Existing Tests

If a test project exists in the solution, execute the test suite:

```bash
dotnet test
```

Review the output for any failing tests that may indicate behavioral regressions introduced during the migration.

### 6. Verify NuGet Package Compatibility

Check that all NuGet packages referenced in the project support the target framework. You can inspect this in the `.csproj` file or by reviewing the output of:

```bash
dotnet list package --outdated
```

Update any packages that have newer versions with cross-platform support.

### 7. Validate Configuration Files

Ensure that configuration files have been properly migrated:

- `Web.config` settings should be moved to `appsettings.json` if this is an ASP.NET Core project.
- Connection strings, app settings, and environment-specific values should be present and correct.

### 8. Test on a Non-Windows Platform (Optional but Recommended)

If cross-platform support is a requirement, run the application on Linux or macOS to confirm there are no platform-specific runtime issues:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Address any `PlatformNotSupportedException` or similar runtime errors that appear.

### 9. Publish the Application

Once validation is complete, publish the application using:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to confirm all required files are present before deploying to the target environment.