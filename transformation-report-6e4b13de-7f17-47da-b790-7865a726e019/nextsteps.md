# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The solution has no build errors following the transformation. The project `GadgetsOnline/GadgetsOnline.csproj` compiled successfully, which indicates the migration to cross-platform .NET has completed without introducing any compilation-level issues.

## Validation Steps

### 1. Restore and Build the Solution

Run the following commands from the solution root to confirm a clean restore and build:

```bash
dotnet restore
dotnet build --configuration Release
```

Verify that no warnings or errors appear in the output.

### 2. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `TargetFramework` is set to the intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the target framework does not match your intended version, update it and re-run the build.

### 3. Run Unit Tests

If the solution contains test projects, execute them to confirm existing functionality has not regressed:

```bash
dotnet test --configuration Release
```

Review the test output and address any failing tests before proceeding.

### 4. Verify Runtime Behavior

Run the application locally and exercise its primary workflows:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Check for any runtime exceptions, missing configuration values, or broken dependencies that would not surface at compile time.

### 5. Check Configuration Files

Review `appsettings.json` (and any environment-specific variants such as `appsettings.Development.json`) to ensure:

- Connection strings are valid and point to accessible data sources.
- Any keys or settings previously held in `Web.config` or `App.config` have been correctly migrated.
- Environment-specific values are not hardcoded.

### 6. Review NuGet Package Compatibility

Run the following command to check for outdated or vulnerable packages:

```bash
dotnet list package --outdated
dotnet list package --vulnerable
```

Update any packages that are flagged, then rebuild and retest.

### 7. Verify Static Assets and Middleware

If `GadgetsOnline` is a web project, confirm that:

- Static files (CSS, JavaScript, images) are served correctly.
- Middleware previously configured in `Global.asax` or `Startup.cs` has been correctly carried over to the current `Program.cs` or `Startup.cs` structure.
- Authentication and authorization configurations behave as expected.

### 8. Database Migrations

If the project uses Entity Framework, verify that migrations are up to date:

```bash
dotnet ef migrations list
dotnet ef database update
```

Confirm the schema matches expectations in the target database.

### 9. Manual Smoke Test

Perform a manual walkthrough of the application's key user-facing features to catch any issues not covered by automated tests, such as:

- Correct page rendering
- Form submissions and data persistence
- Error handling and logging output

## Deployment

Once all validation steps above pass:

1. Publish the application using the Release configuration:

```bash
dotnet publish GadgetsOnline/GadgetsOnline.csproj --configuration Release --output ./publish
```

2. Verify the contents of the `./publish` directory contain all expected files, including runtime dependencies.
3. Deploy the contents of the `./publish` directory to the target server or hosting environment according to your organization's standard deployment procedure.
4. After deployment, repeat the smoke test against the deployed environment to confirm the application is functioning correctly.