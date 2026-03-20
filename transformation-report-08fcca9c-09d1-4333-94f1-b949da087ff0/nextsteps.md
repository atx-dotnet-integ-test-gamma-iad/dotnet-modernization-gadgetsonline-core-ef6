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

Verify that no warnings or errors appear related to missing or incompatible packages. Pay attention to any packages that may have been replaced with compatibility shims during the transformation, as these may need to be updated to their cross-platform equivalents.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Review the output for any warnings, particularly those related to deprecated APIs or platform-specific code paths that may not behave identically on non-Windows platforms.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported cross-platform version, such as `net8.0` or `net6.0`, rather than a Windows-specific moniker like `net48` or `net472`.

### 4. Check for Windows-Specific Dependencies

Search the codebase for any remaining references to Windows-specific APIs or libraries, such as:

- `System.Web` (not available in .NET Core/.NET 5+)
- `Microsoft.Web.*` packages
- Registry access via `Microsoft.Win32`
- Windows Communication Foundation (WCF) server-side components

These will not function correctly on non-Windows platforms and will require replacement or removal.

### 5. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's primary workflows to confirm that core functionality behaves as expected. Check application logs for any runtime exceptions that would not have been caught at compile time.

### 6. Execute Existing Tests

If the solution contains test projects, run them to validate that existing behavior has been preserved:

```bash
dotnet test
```

Review any failing tests to determine whether they indicate a regression introduced during the transformation or a test that requires updating to reflect the new project structure.

### 7. Validate Configuration

Confirm that any configuration previously held in `Web.config` or `App.config` has been correctly migrated to `appsettings.json` or `appsettings.{Environment}.json`. Pay particular attention to:

- Connection strings
- Application settings keys
- Authentication and authorization configuration
- Custom HTTP handlers or modules, which must be replaced with ASP.NET Core middleware

### 8. Database Connectivity

If the application uses a database, verify that the connection string in `appsettings.json` is correct and that the application can connect and perform queries as expected. If Entity Framework is in use, confirm that migrations are compatible with the current version of EF Core.