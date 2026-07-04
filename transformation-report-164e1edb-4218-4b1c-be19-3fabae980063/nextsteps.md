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

Review the output for any warnings related to missing packages or version conflicts and resolve them before proceeding.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the output shows `Build succeeded` with zero errors.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify that the `<TargetFramework>` element is set to the intended cross-platform .NET version (e.g., `net8.0`). Ensure this aligns with your team's supported runtime version.

### 4. Run the Application Locally

Start the application to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and confirm that core functionality behaves the same as it did in the legacy version.

### 5. Execute Existing Tests

If the solution contains test projects, run them to validate that existing behavior is preserved:

```bash
dotnet test
```

Review any failing tests and determine whether they are caused by the migration or represent pre-existing issues.

### 6. Check for Windows-Specific APIs

Even without build errors, the code may reference Windows-specific APIs that will fail at runtime on non-Windows platforms. Search the codebase for usages of the following and assess whether cross-platform alternatives are needed:

- `Microsoft.Win32`
- `System.Windows.Forms`
- `System.Drawing` (GDI+ based)
- Registry access
- Windows file path assumptions (e.g., hardcoded backslashes)

### 7. Review Static Files and wwwroot

If this is an ASP.NET Core web application, verify that static files, views, and configuration files (such as `appsettings.json`) were carried over correctly and are included in the project output.

### 8. Validate Configuration and Middleware

Check `Program.cs` and any `Startup.cs` equivalent to ensure middleware configuration, dependency injection registrations, and application settings are correctly set up for the new hosting model used in cross-platform .NET.

### 9. Database Connectivity

If the application uses a database, confirm that the connection strings in `appsettings.json` are correct for the target environment and that the chosen data access library (e.g., Entity Framework Core) is compatible with the target database provider.

### 10. Manual Functional Testing

Perform a manual walkthrough of the application's primary user flows to identify any runtime issues that automated tests may not cover.