# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts and resolve them before proceeding.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the output shows `Build succeeded` with zero errors.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify that the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is still referencing a Windows-only framework such as `net48`, update it accordingly.

### 4. Run Unit Tests

If the solution contains test projects, execute the test suite to verify that existing functionality behaves as expected:

```bash
dotnet test --configuration Release
```

Review any failing tests and address regressions introduced during the migration.

### 5. Check for Windows-Specific APIs

Even with a successful build, the code may still reference Windows-specific APIs that will fail at runtime on non-Windows platforms. Use the .NET Compatibility Analyzer to surface these issues:

```bash
dotnet build /p:PlatformTarget=AnyCPU
```

Look for analyzer warnings prefixed with `CA1416` (platform compatibility) and replace or guard any Windows-specific calls appropriately.

### 6. Run the Application Locally

Start the application and verify core functionality:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate through the application and confirm that pages load, database connections are established, and no runtime exceptions are thrown.

### 7. Verify Configuration Files

Check that `appsettings.json` (and any environment-specific variants such as `appsettings.Production.json`) are present and contain the correct values for:

- Connection strings
- Logging configuration
- Any application-specific settings that were previously stored in `Web.config` or `App.config`

If settings were migrated from `Web.config`, confirm the values transferred correctly.

### 8. Test Data Access

If the project uses Entity Framework or another ORM, verify that:

- Migrations are up to date by running `dotnet ef migrations list`
- The database schema matches expectations by running `dotnet ef database update` against a development database

### 9. Publish a Release Build

Once all validation steps pass, produce a published output to confirm the deployment artifact is generated correctly:

```bash
dotnet publish GadgetsOnline/GadgetsOnline.csproj --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files are present.

### 10. Smoke Test the Published Output

Run the published output directly to confirm it behaves identically to the development run:

```bash
dotnet ./publish/GadgetsOnline.dll
```

Perform the same manual checks as in step 6 against this published build.