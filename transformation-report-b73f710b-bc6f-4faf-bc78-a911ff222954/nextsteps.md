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

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean build environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to deprecated APIs or nullable reference types, as these may indicate areas of the code that could cause runtime issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version (e.g., `net8.0`). Ensure it is not still referencing a Windows-only framework such as `net48`.

### 4. Check for Windows-Specific Dependencies

Search the project for any remaining references to Windows-specific APIs or libraries, such as:

- `System.Web`
- `Microsoft.Web.*`
- Windows Registry access
- `HttpContext` usage from `System.Web` (as opposed to `Microsoft.AspNetCore.Http`)

These will not cause build errors in all cases but can cause runtime failures on non-Windows platforms.

### 5. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's primary workflows to confirm that core functionality is intact, including any database connections, authentication flows, and page rendering.

### 6. Run Existing Tests

If the solution contains a test project, execute the test suite:

```bash
dotnet test
```

Review any failing tests and determine whether the failures are due to the migration or pre-existing issues.

### 7. Verify Static Files and Configuration

- Confirm that `appsettings.json` contains the correct configuration values, particularly connection strings that may have previously been stored in `Web.config`.
- Verify that static files (CSS, JavaScript, images) are being served correctly by checking the `wwwroot` folder structure and any middleware configuration in `Program.cs` or `Startup.cs`.

### 8. Database Connectivity

If the application uses a database, verify the connection string in `appsettings.json` and confirm that any Entity Framework migrations are up to date:

```bash
dotnet ef database update
```

### 9. Deployment

Once local validation is complete, publish the application using:

```bash
dotnet publish --configuration Release --output ./publish
```

Copy the contents of the `./publish` directory to your target hosting environment and confirm the application starts and operates correctly in that environment.