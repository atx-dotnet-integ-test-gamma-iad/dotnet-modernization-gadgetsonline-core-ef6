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

Perform a full build to confirm the absence of errors in a clean build context:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to deprecated APIs or nullable reference types, as these can indicate areas of the code that may behave differently under cross-platform .NET.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, confirm it is using `net8.0` or `net6.0` rather than a legacy `netcoreapp` moniker.

### 4. Check for Windows-Specific Dependencies

Since this is a cross-platform migration, review the project's dependencies for any packages or APIs that are Windows-specific. Common areas to check:

- Any usage of `System.Web` (not available in cross-platform .NET)
- Registry access (`Microsoft.Win32.Registry`)
- Windows-specific file path assumptions (backslashes, drive letters)

Run the .NET Upgrade Assistant compatibility analyzer if these concerns apply:

```bash
dotnet tool install -g upgrade-assistant
upgrade-assistant analyze GadgetsOnline/GadgetsOnline.csproj
```

### 5. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's primary workflows to confirm that pages load, data is retrieved correctly, and no runtime exceptions are thrown.

### 6. Run Existing Tests

If the solution contains test projects, execute them to validate that existing functionality has not regressed:

```bash
dotnet test
```

Review any failing tests and determine whether the failures are due to the migration or pre-existing issues.

### 7. Verify Static Files and Configuration

For web projects, confirm the following:

- `appsettings.json` contains the correct connection strings and configuration values previously held in `Web.config` or `App.config`
- Static files (CSS, JavaScript, images) are located under `wwwroot` and are being served correctly
- Any HTTP handlers or modules from the legacy project have been replaced with the equivalent ASP.NET Core middleware

### 8. Database Connectivity

If the application uses a database, verify the connection string in `appsettings.json` and confirm the application can connect and perform queries at runtime. If Entity Framework is in use, check that migrations are up to date:

```bash
dotnet ef database update
```