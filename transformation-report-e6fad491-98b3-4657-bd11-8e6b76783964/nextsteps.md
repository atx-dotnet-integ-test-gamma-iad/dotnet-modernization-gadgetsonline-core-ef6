# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Solution

Perform a full build to confirm there are no errors or warnings that may have been missed:

```bash
dotnet build --configuration Release
```

Address any warnings that appear, particularly those related to deprecated APIs or platform compatibility.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to an appropriate modern .NET version, such as `net8.0`:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is targeting an older version such as `net6.0` or `net7.0`, consider upgrading to the latest supported LTS release.

### 4. Check for Removed or Changed APIs

Review the codebase for any usage of APIs that existed in .NET Framework but have changed or been removed in cross-platform .NET. Common areas to check include:

- `System.Web` references, which are not available in cross-platform .NET
- `HttpContext` and related types, which should now come from `Microsoft.AspNetCore.Http`
- `ConfigurationManager`, which should be replaced with `Microsoft.Extensions.Configuration`
- Windows-specific APIs such as the registry or certain `System.Drawing` methods

### 5. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and verify that all pages, routes, and features behave as expected.

### 6. Run Existing Tests

If the solution contains test projects, execute them to confirm existing functionality has not regressed:

```bash
dotnet test
```

Review any failing tests and determine whether they indicate a functional regression or a test that needs to be updated for the new framework.

### 7. Review Static Files and Configuration

- Confirm that `appsettings.json` contains all configuration values that were previously in `Web.config` or `App.config`.
- Verify that static files such as CSS, JavaScript, and images are served correctly.
- Check that connection strings and any environment-specific settings are properly configured.

### 8. Validate Database Connectivity

If the application uses a database, confirm that the connection string is correct and that the application can connect and perform operations as expected. If Entity Framework is in use, verify that migrations are up to date:

```bash
dotnet ef database update
```

### 9. Deployment

Once the above steps have been completed and validated:

- Publish the application using the following command:

```bash
dotnet publish --configuration Release --output ./publish
```

- Copy the contents of the `./publish` directory to your target hosting environment.
- Ensure the hosting environment has the appropriate .NET runtime installed. The runtime version must match or be compatible with the `<TargetFramework>` specified in the project file.
- Configure the web server (such as IIS or Nginx) to point to the published output and to use the correct process model for ASP.NET Core applications.