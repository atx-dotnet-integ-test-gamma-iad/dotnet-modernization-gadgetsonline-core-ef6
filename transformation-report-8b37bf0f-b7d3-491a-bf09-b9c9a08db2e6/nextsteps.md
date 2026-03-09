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

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean build environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to nullable reference types or deprecated APIs, as these can indicate subtle compatibility issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to an appropriate modern .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is targeting `net6.0` or `net7.0`, consider upgrading to `net8.0` as those versions are out of long-term support.

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and exercise its core functionality, paying attention to:

- Database connectivity and any Entity Framework migrations that may need to be applied
- Authentication and authorization flows
- Any file system paths that may have been hardcoded for Windows and are now running on a different OS

### 5. Apply and Verify Database Migrations

If the project uses Entity Framework Core, verify that migrations are up to date:

```bash
dotnet ef migrations list --project GadgetsOnline/GadgetsOnline.csproj
dotnet ef database update --project GadgetsOnline/GadgetsOnline.csproj
```

If the project was migrated from Entity Framework 6 (non-Core), confirm that the migration to EF Core was completed and that all queries behave as expected.

### 6. Execute Unit and Integration Tests

If a test project exists in the solution, run all tests to validate correctness:

```bash
dotnet test
```

Review any failing tests carefully, as failures at this stage often reveal runtime incompatibilities that did not produce build errors.

### 7. Check for Windows-Specific APIs

Search the codebase for any remaining usage of Windows-specific APIs that may cause runtime failures on non-Windows platforms, such as:

- `System.Web` types that were not fully replaced
- Windows registry access
- COM interop
- `HttpContext.Current` usage patterns from classic ASP.NET

### 8. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required assets, static files, and configuration files are present before deploying to the target environment.