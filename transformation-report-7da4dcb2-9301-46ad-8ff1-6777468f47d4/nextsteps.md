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

Review the output for any warnings related to missing packages or version conflicts and resolve them before proceeding.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean build environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during the build, particularly those related to deprecated APIs or nullable reference types, as these can indicate compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version (e.g., `net8.0`). Ensure this aligns with the runtime environment you plan to deploy to.

### 4. Check for Windows-Specific Dependencies

Even with a successful build, some dependencies may only function correctly on Windows. Review your `.csproj` file and `Program.cs` or `Startup.cs` for any of the following:

- References to `Microsoft.Web.*` or `System.Web.*` namespaces
- Usage of Windows Registry, COM interop, or MSMQ
- Any `RuntimeInformation.IsOSPlatform(OSPlatform.Windows)` guards that may have been added during transformation

Replace or remove any Windows-specific code paths that are not compatible with cross-platform .NET.

### 5. Run Unit Tests

If the solution contains test projects, execute them to verify functional correctness after the migration:

```bash
dotnet test --configuration Release
```

Review any failing tests and determine whether failures are due to the migration or pre-existing issues.

### 6. Run the Application Locally

Start the application locally to confirm runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate through the application and verify that core functionality, such as routing, data access, and authentication, behaves as expected.

### 7. Verify Database Connectivity

If the application uses Entity Framework or another data access layer, confirm that:

- Connection strings in `appsettings.json` are correct for the target environment
- Any EF Core migrations are up to date by running:

```bash
dotnet ef database update
```

- The database provider package (e.g., `Microsoft.EntityFrameworkCore.SqlServer`) is compatible with the target framework version

### 8. Review Static Files and Middleware Configuration

In cross-platform .NET, file path handling is case-sensitive on Linux. Verify that:

- All static file references use consistent casing
- Middleware is configured correctly in `Program.cs` or `Startup.cs`
- Any file I/O operations use `Path.Combine` rather than hardcoded path separators

### 9. Check Application Configuration

Confirm that `appsettings.json` contains all necessary configuration values that were previously stored in `Web.config` or `App.config`. The transformation process should have migrated these, but it is worth verifying manually, particularly for:

- Connection strings
- Application settings
- Custom configuration sections