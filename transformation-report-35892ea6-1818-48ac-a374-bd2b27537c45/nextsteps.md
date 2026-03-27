# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no errors or warnings:

```bash
dotnet build --configuration Release
```

Address any warnings that surface at this stage, particularly those related to deprecated APIs or nullable reference types, as these can indicate subtle compatibility issues introduced during migration.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version (e.g., `net8.0`):

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is set to `net48` or any other .NET Framework moniker, the migration to cross-platform .NET is incomplete.

### 4. Check for Windows-Specific Dependencies

Inspect the project file and source code for any remaining references to Windows-specific libraries or APIs, such as:

- `System.Web` (not available in cross-platform .NET)
- `Microsoft.Web.Infrastructure`
- Windows Registry access
- `HttpContext` usage from `System.Web` rather than `Microsoft.AspNetCore.Http`

Replace or remove any such dependencies with their cross-platform equivalents.

### 5. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Verify that the application starts without runtime exceptions and that core functionality behaves as expected.

### 6. Execute Existing Tests

If the solution contains test projects, run them to validate that existing behavior has been preserved:

```bash
dotnet test
```

Review test results and investigate any failures, as they may point to behavioral differences between .NET Framework and cross-platform .NET.

### 7. Verify Static Files and Configuration

- Confirm that `appsettings.json` is present and contains the correct configuration values previously held in `Web.config` or `App.config`.
- Verify that static files (CSS, JavaScript, images) are served correctly by checking the presence of `app.UseStaticFiles()` in the application startup configuration.

### 8. Validate Database Connectivity

If the application uses a database, confirm that:

- The connection string in `appsettings.json` is correct.
- The data access layer (Entity Framework or otherwise) functions correctly against the target database.
- Any pending migrations are applied:

```bash
dotnet ef database update
```

### 9. Test on a Non-Windows Platform (Optional but Recommended)

Since the goal is cross-platform compatibility, run the application on Linux or macOS to confirm there are no hidden platform-specific dependencies:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Resolve any `PlatformNotSupportedException` or similar runtime errors that appear only on non-Windows systems.

### 10. Publish the Application

Once all validation steps pass, publish the application to confirm the output is complete and self-contained:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files are present before deploying to the target environment.